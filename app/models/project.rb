class Project < ActiveRecord::Base
  attr_accessible :description, :github_link, :name, :subtitle, :url
end
