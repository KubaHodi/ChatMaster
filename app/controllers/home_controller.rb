class HomeController < ApplicationController
  def index
    @users = User.all_except(session[:user_id]).count
  end
end
