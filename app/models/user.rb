class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :token, :github_login, :full_name, :github_html_url, :profile_image
  has_many :project_users
  has_many :projects, :through => :project_users

  has_attached_file :profile_image,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"


  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  def is_filled_out?(params, attribute_name_as_string)
    params[:user][attribute_name_as_string.to_sym].strip != ""
  end  

  def attribute_value(params, attribute_name_as_string)
    params[:user][attribute_name_as_string.to_sym]
  end

  def update_attribute(params, attribute_name_as_string)
    updated_value ||= self.attribute_value(params, attribute_name_as_string) if self.is_filled_out?(params, attribute_name_as_string)
    self.send("#{attribute_name_as_string}=", updated_value) 
  end




end