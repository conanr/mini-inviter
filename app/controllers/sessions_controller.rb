class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.create_from_oauth_hash(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end