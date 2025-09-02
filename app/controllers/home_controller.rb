class HomeController < ApplicationController
  def index
    @users = User.count
    @rooms = Room.public_rooms.count
  end
end
