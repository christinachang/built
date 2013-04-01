class Image < ActiveRecord::Base
  attr_accessible :image_type, :upload, :position, :images_attributes
  belongs_to :project

  has_attached_file :upload,
  :styles => { :medium => "4000x4000>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"

  # validates :upload_file_size, :presence => true, :message => "please upload 1 cover image and at least 1 screenshot"
  
  validates :upload_file_size, :presence => { :message => "Need at least one screenshot" }, :if => lambda { |u| u.image_type=="screenshot" }
  validates :upload_file_size, :presence => { :message => "Need one cover image" }, :if => lambda { |u| u.image_type=="cover" }

  # validates :upload, :presence => {:message => "please upload 1 cover image and at least 1 screenshot"}
  # :image_type, :value => "cover"
end

  
