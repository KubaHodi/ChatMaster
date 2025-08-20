class RoomsController < ApplicationController
    before_action :authorize

    def index
        @room = Room.new
        @rooms = Room.public_rooms
        @users = User.all_except(session[:user_id])
    end

    def create
        @room = Room.create(name: params[:name])
    end
end