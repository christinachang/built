class Image < ActiveRecord::Base
  attr_accessible :image_type, :upload, :position, :images_attributes, :upload_file_size
  belongs_to :project

  has_attached_file :upload,
  :styles => { :medium => "4000x4000>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"

  validates :upload_file_size, :presence => {:message => "please upload 1 cover image and at least 1 screenshot"}

  # validates :images_attributes => {:image_type => {:value => "cover"}}, :presence => {:message => "please upload 1 cover image and at least 1 screenshot"}

  # :image_type, :value => "cover"
  # :image_type, :value => "screenshot"

end

  
