class UsersController < ApplicationController
    skip_before_action :authorize, only: %w[ new create ]
    before_action :set_user, only: %w[ edit update show ]
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @current_user =  logged_user
        @users = User.all_except(@current_user)

        @rooms = Room.public_rooms
        @room = Room.new
        @room_name = get_name(@user, @current_user)
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)

        @message = Message.new
        @messages = @single_room.messages

        render "rooms/show"

    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to login_path, notice: "Successfully created user" }
                format.json { render :show, status: :created, location: @user }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to login_path, alert: "Profile updated succesfully"    
        else
        flash[:notice] = @user.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
        end
    end
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.expect(user: [ :username, :password, :password_confirmation, :avatar, :email ] )
    end
    def get_name(user_1, user_2)
        users = [user_1, user_2].sort
        "private_#{users[0].id}_#{users[1].id}"
    end
end
