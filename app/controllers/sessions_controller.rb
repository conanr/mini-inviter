class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.from_oauth_hash(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.events && !user.events.empty?
      redirect_to events_path, notice: "Signed in!"
    else
      redirect_to new_event_path, notice: "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end