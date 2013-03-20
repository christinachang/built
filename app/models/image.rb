class Image < ActiveRecord::Base
  attr_accessible :image_type, :url
  belongs_to :project
  has_attached_file :thumbnail,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"
end
