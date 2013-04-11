class SessionsController < ApplicationController
  def new
    redirect_to '/auth/github'
  end

  def test
    client = Octokit::Client.new(:login => current_user.github_login, :oauth_token => current_user.token, :auto_traversal => true)
    data_structure = client.commits('flatiron-school/built')
    @data_hash = { }
    @login_array = []
    @login_hash = {}
   
    data_structure.each do |instance|
      committer_name = instance.author.login
      commit_date = instance.commit.author.date.to_date.strftime('%m-%d')
      commit_date = instance.commit.author.date.to_date.to_s
      message = instance.commit.message
      @data_hash[commit_date.to_sym] ||= {}
      @data_hash[commit_date.to_sym][committer_name.to_sym] ||= 0
      @data_hash[commit_date.to_sym][committer_name.to_sym] += 1
      @login_array << committer_name unless @login_array.include?(committer_name)
  end
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
    @user = User.find_or_create_by_github_login(:github_login => returned_github_login, :token => returned_github_token, :full_name => 'anonymous')
  
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


