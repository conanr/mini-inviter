class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def authenticate_user
    unless current_user
      redirect_to signin_path
    end
  end
  helper_method :authenticate_user
end
