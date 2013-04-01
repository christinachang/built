class Project < ActiveRecord::Base

  attr_accessible :description, :github_link, :name, :repo_name, :live_url, :forks, :watchers, :language, :images_attributes
  has_many :images
  has_many :project_users
  has_many :users, :through => :project_users

  accepts_nested_attributes_for :images

  validates :repo_name, :presence => {:message => "please enter a repo name"}

  def create_github_client(current_user)
    @@octokit_client = Octokit::Client.new(:login => current_user.github_login, :oauth_token => current_user.token)
  end

  def get_repo_hash(repo_name, current_user)
    create_github_client(current_user).repo(repo_name)
  end

  def set_github_attributes(params, current_user) 
    repo_hash = self.get_repo_hash(params[:project][:repo_name],current_user)
    self.repo_name = params[:project][:repo_name]
    self.repo_url = repo_hash[:html_url]
    self.ssh_url = repo_hash[:ssh_url]
    self.description = repo_hash[:description]
    self.language = repo_hash[:language]
    self.watchers = repo_hash[:watchers]
    self.forks = repo_hash[:forks]
    self.name = repo_hash[:name]
  end

  def get_collaborator_logins(repo_name, client)
     assignment_hash = client.collabs(repo_name)
     assignment_hash.collect do |collaborator|
       {:github_login=> collaborator.login}
    end
  end

  def get_name_from_login(login, client)
    client.user(login[:github_login]).name
  end

  def get_github_html_url_from_login(login, client)
    client.user(login[:github_login]).html_url
  end

  def prepare_mass_assignment(repo_name, current_user)
    #create github client
    client =  create_github_client(current_user)
    #create collab logins
    logins_assignment_hash = get_collaborator_logins(repo_name, client)
    #use the logins from login hash to retrieve other attributes for each collaborator(i.e., 'user')
    logins_assignment_hash.collect do |login|
      name = get_name_from_login(login, client)
      html_url = get_github_html_url_from_login(login, client)
    {:github_login=> login[:github_login], :full_name => name, :github_html_url => html_url}
    end
  end

  def create_associated_user_records(params, current_user)

    assignment_hash = self.prepare_mass_assignment(params[:project][:repo_name],current_user)
    assignment_hash.each do |attributes|
      @user = User.find_by_github_login(attributes[:github_login])
      ##if the user being iterated over doesn't exist,create a user w/ an association 
    unless @user
      @user = User.new
      @user.full_name = "Anonymous"
      self.users.build(attributes)
   
    else #if user being iterated over DOES exist, just build the join row
      unless @user.full_name
        @user.full_name = "Anonymous"
      end
    self.project_users.build(:user_id => @user.id)
      self.save
    end

    end
  end

end
