class Project < ActiveRecord::Base

  attr_accessible :description, :github_link, :repo_name, :subtitle, :url, :images_attributes
  has_many :images
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

  def get_collaborator_logins(repo_name)
     repo_hash = @@octokit_client.collabs(repo_name)
     repo_hash.collect do |collaborator|
       {:login_name => collaborator.login}
    end
  end

'JohnKellyFerguson/octomaps'

  def get_fullnames_from_logins(repo_name)
    logins = get_logins_from_repo_hash(repo_name)
    logins.collect do |login|
      @@octokit_client.user(login[:login_name]).name
    end
  end

  [{:name => 'Jon', login =>'whatever:}, {}]

  

end
