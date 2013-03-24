class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :token, :github_login, :full_name, :github_html_url, :profile_image
  has_many :project_users
  has_many :projects, :through => :project_users

  has_attached_file :profile_image,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"
  # validates_presence_of :email
  # validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  # validates_uniqueness_of :email, :case_sensitive => false
  # validates_presence_of :password
  # # validates_confirmation_of :password
  # has_secure_password

  # before_save :encrypt_password

  # def encrypt_password
  #   if password.present?
  #     self.password_salt = BCrypt::Engine.generate_salt
  #     self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  #   end
  # end

  # def self.authenticate(email, password)
  #   user = find_by_email(email)
  #   if user && user.password_hash == BCrypt::Engine.hash_secret(password, password_salt)
  #     user
  #   else
  #     nil
  #   end
  # end

def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
end

end
