class Project < ActiveRecord::Base
  attr_accessible :description, :github_link, :name, :subtitle, :url, :thumbnail
  has_attached_file :thumbnail,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"
end
