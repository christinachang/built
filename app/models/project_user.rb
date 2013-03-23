class ProjectUser < ActiveRecord::Base
	attr_accessible :user_id
  belongs_to :project
  belongs_to :user

end
