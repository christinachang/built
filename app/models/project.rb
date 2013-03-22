class Project < ActiveRecord::Base

  attr_accessible :description, :github_link, :repo_name, :url, :forks, :watchers, :language, :images_attributes
  has_many :images
  has_many :project_users
  has_many :users, :through => :project_users

  accepts_nested_attributes_for :images

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", 
                                         :password => "flatiron001")

  def get_repo_hash(repo_name)
    @@octokit_client.repo(repo_name)
  end

  def get_html_url(repo_name)
    repo_hash = self.get_repo_hash(repo_name)
    repo_hash[:html_url]
  end

  def get_ssh_url(repo_name)
    repo_hash = self.get_repo_hash(repo_name)
    repo_hash[:ssh_url]
  end

  def get_description(repo_name)
    repo_hash = self.get_repo_hash(repo_name)
    repo_hash[:description]
  end

  def get_forks(repo_name)
    repo_hash = self.get_repo_hash(repo_name)
    repo_hash[:forks]
  end

  def get_watchers(repo_name)
    repo_hash = self.get_repo_hash(repo_name)
    repo_hash[:watchers]
  end

  def get_language(repo_name)
    repo_hash = self.get_repo_hash(repo_name)
    repo_hash[:language]
  end

  def set_attributes(params) 
    self.repo_name = params[:repo_name]
    self.repo_url = self.get_html_url(params[:repo_name])
    self.ssh_url = self.get_ssh_url(params[:repo_name])
    self.description = self.get_description(params[:repo_name])
    self.language = self.get_language(params[:repo_name])
    self.watchers = self.get_watchers(params[:repo_name])
    self.forks = self.get_forks(params[:repo_name])
  end

  def get_collaborator_logins(repo_name)
     repo_hash = @@octokit_client.collabs(repo_name)
     repo_hash.collect do |collaborator|
       {:github_login=> collaborator.login}
    end
  end

  def get_name_from_login(login)
    @@octokit_client.user(login[:github_login]).name
  end

  def get_github_html_url_from_login(login)
    @@octokit_client.user(login[:github_login]).html_url
  end

  def prepare_mass_assignment(repo_name)
    logins = get_collaborator_logins(repo_name)
    logins.collect do |login|
      name = get_name_from_login(login)
      html_url = get_github_html_url_from_login(login)
    {:github_login=> login[:github_login], :full_name => name, :github_html_url => html_url}
    end
  end

  def create_associated_user_records(params)
    assignment_hash = self.prepare_mass_assignment(params[:repo_name])
    assignment_hash.each do |attributes|
      @user = self.users.build(attributes)
      @user.save
    end
  end

end


