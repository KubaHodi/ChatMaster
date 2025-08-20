class HomeController < ApplicationController
  def index
    @users = User.all_except(session[:user_id]).count
    @rooms = Room.all.count
  end
end
