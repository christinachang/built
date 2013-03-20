class Project < ActiveRecord::Base
  attr_accessible :description, :github_link, :repo_name, :subtitle, :url, :thumbnail
  has_attached_file :thumbnail,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", 
                                          :password => "flatiron001")

  def get_ssh_url(repo_name)
    repo_hash = @@octokit_client.repo(repo_name)
    repo_hash[:url]
  end

end
