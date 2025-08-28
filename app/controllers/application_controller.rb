class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authorize
  before_action :set_query
  helper_method :logged_user

  def set_query
    @query = User.ransack(params[:q])
  end

  def logged_user
    if session[:user_id]
      @logged_user = User.find(session[:user_id])
    end
  end

  def logged_in?
    !logged_user.nil?
  end

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
