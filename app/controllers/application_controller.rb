class ApplicationController < ActionController::Base
protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
 
helper_method :current_user
  
  def test_exception_notification
    raise 'Testing, 1 2 3.'
  end

private 

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user

	def authorize
		redirect_to projects_path, alert: "Please log in" if current_user.nil?
	end

end
