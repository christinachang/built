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
		@user.email = params[:user][:email] unless params[:user][:email].strip == ""
		@user.profile_image = params[:user][:profile_image] if params[:user][:profile_image]
		@user.save
		render 'show'
	end

end
