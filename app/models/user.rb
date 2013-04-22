class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :token, :github_login, :full_name, :github_html_url, :avatar_url, :semester_id
  has_many :project_users
  has_many :projects, :through => :project_users

  has_attached_file :profile_image,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"

  validates :full_name, :presence => {:message => 'please enter full name'}
  validates_format_of :github_html_url, :allow_blank => true, :with => /github/, :if => :github_html_url, :message => "please provide an accurate github url"
  validates_format_of :linkedin_url, :allow_blank => true, :with => /linkedin/, :if => :linkedin_url, :message => "please provide an accurate linkedin url"
  validates_format_of :facebook_url, :allow_blank => true, :with => /facebook/, :if => :facebook_url, :message => "please provide an accurate facebook url"
  validates_format_of :twitter_url, :allow_blank => true, :with => /twitter/, :if => :twitter_url, :message => "please provide an accurate twitter url"

  @@admin = ["meowist", "christinachang","modernlegend","anabecker"]

  def has_full_name?
    self.full_name.downcase.capitalize == 'Anonymous'
  end

  def is_authorized?(params)
    self.is_an_admin? || self.is_a_member_of_this_project?(params)
  end

  def is_an_admin?
   @@admin.include?(self.github_login)
  end

  def is_a_member_of_this_project?(params)
     self.projects.where("id = ?", params[:id]) != []
  end

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  def is_filled_out?(params, attribute_name_as_string)
    params[:user][attribute_name_as_string.to_sym].strip != ""
  end

  def update_attribute(params, attribute_name_as_string)
    updated_value ||= self.attribute_value(params, attribute_name_as_string) if self.is_filled_out?(params, attribute_name_as_string)
    self.send("#{attribute_name_as_string}=", updated_value)
  end

  def attribute_value(params, attribute_name_as_string)
    params[:user][attribute_name_as_string.to_sym]
  end





end