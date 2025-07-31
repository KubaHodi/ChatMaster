class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_uesr
  before_action :authorize

  def current_uesr
    if session[:user_id]
      @current_uesr = User.find(session[:user_id])
    end
  end

  def log_in(user)
    session[:user_id] = user.id
    @current_uesr = user
    redirect_to root_path
  end

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
