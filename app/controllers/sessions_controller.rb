class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[ new create ]
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      redirect_to root_path
    else
      redirect_to login_url, alert: "Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end
end
