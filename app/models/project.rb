class Project < ActiveRecord::Base
  attr_accessible :description, :github_link, :name, :subtitle, :url, :images_attributes
  has_many :images

  accepts_nested_attributes_for :images
end
