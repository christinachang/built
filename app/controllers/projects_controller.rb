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
    #if the project is in our database
    if Project.find_by_repo_name(params[:project][:repo_name])
      flash[:error] = "That Repo's already been inserted, yo." 
      @project = Project.new 
      @project.images.build
      render 'new'
      #if the project isn't in our db
    else
      #if the user submitted a blank entry
      if params[:project][:repo_name].blank?
        flash[:error] = "Please enter a repo name."
        render :new
        #go through the process of creating this project and its associated users
      else
        @project = Project.create(params[:project])
        @project.set_github_attributes(params,current_user)
        @project.create_associated_user_records(params,current_user) 
        
        #if the project saves successfully (due to valid images), redirect to the show page for the project
        if @project.save
           redirect_to(@project)
        #redirect user to back to the 'new' form 
        else 
          #the empty array code and build code is for dealing with the fields_for issue on the 'new form'
          @project.images = []
          @project.images.build       
          render :new
        end
      end
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
      true
      # redirect_to projects_path , alert: "ACCESS DENIED!" unless current_user.is_authorized?(params)
    end

end
