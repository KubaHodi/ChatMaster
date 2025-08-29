class SessionsController < ApplicationController
  skip_before_action :authorize
  helper_method :logged_user
  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_url, notice: "Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end
end
