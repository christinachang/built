class ProjectsController < ApplicationController

  before_filter :authorize, only: [:new, :edit]
  before_filter :project_edit_authorization, only: [:edit, :destroy]

  #check to see if return 

  def filter
    if params[:semesterID] == "all"
      @projects = Project.all
    else
      @projects = Project.where("semester_id = ?", params[:semesterID])
    end
   respond_to do |format|
      format.js {}
      format.html { render 'show'}
    end
  end 

  # GET /projects
  # GET /projects.json
  def index
    # @projects = Project.find(:all, :order => "name")
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
 @project = Project.find(params[:id])


    client = Octokit::Client.new(:login => ENV['GITHUB_FLATIRON_ID'], :oauth_token => ENV['GITHUB_FLATIRON_TOKEN'], :auto_traversal => true)
    data_structure = client.commits(@project.repo_name)
    @data_hash = {}
    @login_array = []
    @login_hash = {}
   
    data_structure.each do |instance|
      committer_name = instance.author.login
      commit_date = instance.commit.author.date.to_date.to_s
#go through each commit - 
  #if the day doesn't exist as a key, create it
  #if the day exists, make a key inside of it with the committers name
  #and add a counter
      @data_hash[commit_date.to_sym] ||= {}
      @data_hash[commit_date.to_sym][committer_name.to_sym] ||= 0
      @data_hash[commit_date.to_sym][committer_name.to_sym] += 1
      @login_array << committer_name unless @login_array.include?(committer_name)
    end

#################
  @sorted_array = @data_hash.keys.sort 


@login_array.each do |person| 
@login_hash[person.to_sym] = @sorted_array.collect do |date| 
   @data_hash[date.to_sym][person.to_sym] || 0 
   end 
end

##putting the data_hash in sequential order as 'sorted_hash'
 @sorted_hash = {} 
 @sorted_array.each do |element| 
 @sorted_hash[element] ||= { } 
 @sorted_hash[element] = @data_hash[element] 

 end 


 @final_hash = {} 

 @login_array.each do |person| 
 @sorted_hash.each do |k,v| 
 @final_hash[person] ||= [] 
 @final_hash[person] << [(Date.parse(k.to_s).to_time.to_i * 1000), @sorted_hash[k][person.to_sym]] 
  end 
end 



####################### second method #########################

    @data_array = []
  
    data_structure.each do |instance|
        
      commit_time = instance.commit.author.date.to_datetime.in_time_zone("Eastern Time (US & Canada)")
      if commit_time.min >= 30
      commit_hour = commit_time.beginning_of_hour
      else 
      commit_hour = commit_time.end_of_hour
      end
      @data_array << commit_hour.strftime("%l%P").strip.to_sym
    end

     day_hour_array = (0..23).to_a
     @count = {}
     day_hour_array.each do |element|
      hour = DateTime.parse(element.to_s + ":00").strftime("%l%P").strip.to_sym
      @count[hour] = 0
     end
    

     @total = 0.to_f
     @data_array.sort.each do |value| 
      @count[value] ||= 0
      @count[value] += 1    
      @total += 1              
    end

      @count.each do |key, value|
      @count[key] = ((value/@total) * 100).round(2)
   end
   @percent_array = []
   @hour_array = []
   @count.each do |k,v|
   @hour_array << k
   @percent_array << v
 end

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
      format.html { redirect_to current_user, notice: 'Project was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private 
    def project_edit_authorization
      # true
      redirect_to projects_path , alert: "ACCESS DENIED!" unless current_user.is_authorized?(params)
    end

end
