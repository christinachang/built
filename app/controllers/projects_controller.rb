class ProjectsController < ApplicationController

  before_filter :authorize, only: [:new, :edit]
  before_filter :project_edit_authorization, only: [:edit, :destroy]

  #check to see if return 

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @project.images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
 
  def create
    unless Project.find_by_repo_name(params[:project][:repo_name])
      unless params[:project][:repo_name].strip != ""
        @project = Project.new
        @project.images.build
        flash[:error] = "Please enter a repo name."
        render :new
      else
        @project = Project.new(params[:project])
        @project.set_github_attributes(params,current_user)
        @project.create_associated_user_records(params,current_user) 
        if @project.save
           redirect_to(@project)
        else 
          @project.images = []
          @project.images.build       
          render :new
        end
      end
    else
    @project = Project.new
    @project.images.build
    flash[:error] = "That repo's already been submitted, yo."  
    render :new
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    
    @project = Project.find(params[:id])
    
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private 
    def project_edit_authorization
      redirect_to projects_path , alert: "Access denied!" unless current_user.is_authorized?(params)
    end

end
