class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :authenticate_user,
                :find_event, :verify_event_owner

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    unless current_user
      redirect_to signin_path
    end
  end

  def find_event
    @event = Event.find params[:event_id]
  end

  def verify_event_owner
    unless @event.user == current_user
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
