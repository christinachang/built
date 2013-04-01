class Image < ActiveRecord::Base
  attr_accessible :image_type, :upload, :position, :images_attributes
  belongs_to :project

  has_attached_file :upload,
  :styles => { :medium => "4000x4000>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"

  validates :upload_file_size, :presence => { :message => "Please upload at least one screenshot" }, :if => lambda { |u| u.image_type=="screenshot" }
  validates :upload_file_size, :presence => { :message => "Please upload a cover image" }, :if => lambda { |u| u.image_type=="cover" }
  #validates :upload_file_size, :less_than => 2.megabytes #=> { :message => "Images cannot be more than 2 megabytes in size" }

end

  
