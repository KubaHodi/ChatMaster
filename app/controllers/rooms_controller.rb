class RoomsController < ApplicationController

    def index
        @room = Room.new
        @rooms = Room.public_rooms
        @users = User.all_except(session[:user_id])
        
    end

    def create
        @room = Room.create(name: params[:name])
    end

    def show
        @current_user = logged_user
        @room = Room.find(params[:id])
        @message = Message.new     
        @messages = @room.messages.order(created_at: :asc) 
        @single_room = Room.find(params[:id])     
    end
end
