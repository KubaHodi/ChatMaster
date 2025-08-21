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

    def show
        @current_user = User.find_by(params[:user_id])
        @room = Room.find(params[:id])
        
    end
end
