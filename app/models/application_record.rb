class ApplicationRecord < ActiveRecord::Base
  include ActionController::Helpers
  primary_abstract_class
  helper_method :current_user
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
