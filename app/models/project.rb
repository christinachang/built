class Project < ActiveRecord::Base


  attr_accessible :description, :github_link, :name, :repo_name, :live_url, :forks, :watchers, :language, :images_attributes
  add basic authorization
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

  def get_html_url(repo_name, current_user) #creates a new client
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:html_url]
  end

  def get_ssh_url(repo_name, current_user) #creates a new client
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:ssh_url]
  end
  


  def get_description(repo_name, current_user)
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:description]
  end

  def get_forks(repo_name, current_user)
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:forks]
  end

  def get_watchers(repo_name, current_user)
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:watchers]
  end

  def get_language(repo_name, current_user)
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:language]
  end

  def get_repo_name(repo_name, current_user)
    repo_hash = self.get_repo_hash(repo_name, current_user)
    repo_hash[:name]
  end

  def set_github_attributes(params, current_user) 
    self.repo_name = params[:project][:repo_name]
    self.repo_url = self.get_html_url(params[:project][:repo_name],current_user)
    self.ssh_url = self.get_ssh_url(params[:project][:repo_name],current_user)
    self.description = self.get_description(params[:project][:repo_name],current_user)
    self.language = self.get_language(params[:project][:repo_name],current_user)
    self.watchers = self.get_watchers(params[:project][:repo_name],current_user)
    self.forks = self.get_forks(params[:project][:repo_name],current_user)
    self.name = self.get_repo_name(params[:project][:repo_name],current_user)
  end

  def get_collaborator_logins(repo_name, current_user)
     repo_hash = create_github_client(current_user).collabs(repo_name)
     repo_hash.collect do |collaborator|
       {:github_login=> collaborator.login}
    end
  end

  def get_name_from_login(login, current_user)
    create_github_client(current_user).user(login[:github_login]).name
  end

  def get_github_html_url_from_login(login, current_user)
    create_github_client(current_user).user(login[:github_login]).html_url
  end

  def prepare_mass_assignment(repo_name, current_user)
    logins = get_collaborator_logins(repo_name, current_user)
    logins.collect do |login|
      name = get_name_from_login(login, current_user)
      html_url = get_github_html_url_from_login(login, current_user)
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
      self.project_users.build(:user_id => @user.id)
      self.save
      end
    end

    end
  end

end
