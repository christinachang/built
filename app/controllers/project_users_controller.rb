class ProjectUsersController < ApplicationController

def show
    @project_user = Project_User.find(params[:id])
  end

end
