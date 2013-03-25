class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new
		
	end

	def show
		@user = current_user
	end

	def update
		@user = current_user

		attributes = params[:user].reject{ |k| k == "profile_image" }.keys
		 @user.profile_image = params[:user][:profile_image] if params[:user][:profile_image]
		
		attributes.each do |attribute|
			@user.update_attribute(params, attribute)
		@user.save
	 end
	 	render 'show'
	end


end
