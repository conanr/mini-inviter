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
  
  def find_event
    @event = Event.find params[:event_id]
  end
  helper_method :find_event
  
  def verify_event_owner
    unless @event.user == current_user
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  helper_method :verify_event_owner
end
