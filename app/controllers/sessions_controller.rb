class SessionsController < ApplicationController
  def new
    redirect_to '/auth/github'
  end


@@flatiron_members = Octokit::Client.new(:login => ENV['GITHUB_FLATIRON_ID'], :oauth_token => ENV['GITHUB_FLATIRON_TOKEN']).organization_members('flatiron-school').collect do |user|
      user.login  
    end

  def create
    #pull the information frrom the return hash
    #check if the User exists (find by github login)
    #if user exists, log them in 
    #if user doesn't exist, create new user record

    github_oauth_return_hash = request.env['omniauth.auth']
    returned_github_token = github_oauth_return_hash[:credentials][:token]
    returned_github_login = github_oauth_return_hash[:extra][:raw_info][:login]
    returned_github_image_url = github_oauth_return_hash[:info][:image]
    returned_github_avatar_url = github_oauth_return_hash[:extra][:raw_info][:avatar_url]
    returned_github_html_url = github_oauth_return_hash[:extra][:raw_info][:html_url]
    
    @user = User.find_or_create_by_github_login(:github_login => returned_github_login, :token => returned_github_token, :full_name => 'anonymous', :avatar_url => returned_github_avatar_url, :github_html_url => returned_github_html_url)
    unless @@flatiron_members.include?(returned_github_login)
        redirect_to projects_path, notice: "You gotta be a flatiron-school member. Sorry, bud!" and return
    end
    if @user
  		session[:user_id] = @user.id
  		redirect_to @user, notice: "Logged in!"
  	else
  		flash.now.alert = "Login or password is invalid."
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to projects_path, notice: "Logged out"
  end
end
