class RoomsController < ApplicationController

    def index
        @room = Room.new
        @rooms = Room.public_rooms
        @users = User.all_except(session[:user_id])
        
    end

    def create
        @room = Room.new(room_params)

        if @room.save   
            respond_to do |format|
                format.turbo_stream
                format.html { redirect_to rooms_path }
            end
        else
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace("room_form", partial: "layouts/new_room_form"), locals: {room: @room} }
                format.html { render :new, status: unprocessable_entity }
            end
        end
    end

    def show
        @current_user = logged_user
        @room = Room.find(params[:id])
        @message = Message.new     
        @messages = @room.messages.order(created_at: :asc) 
        @single_room = Room.find(params[:id])     
    end

    private

    def room_params
        params.expect(room: [ :name ] )
    end
end
