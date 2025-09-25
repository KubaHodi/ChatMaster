class UsersController < ApplicationController
    skip_before_action :authorize, only: %w[ new create ]
    before_action :set_user, only: %w[ edit update show ]
    before_action :check_user, only: %w[ show ]
    before_action :authorize_friendship, only: %w[ show ]
    before_action :deny_entrance, only: %w[ edit update ]
    before_action :check_logged_user, only: %w[ new ]
    before_action :check_blocked_user, only: %w[ show ]
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
        @user.build_profile
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                @profile = Profile.new(user_id: @user.id, status: params[:user][:profile_attributes][:status])
                if @profile.save
                format.html { redirect_to login_path, notice: "Successfully created user" }
                format.json { render :show, status: :created, location: @user }
                else
                    format.html { render :new, status: :unprocessable_entity }
                    format.json { render json: @profile.errors, status: :unprocessable_entity }
                end
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
        if @user.update(edit_user_params)
            redirect_to login_path, alert: "Profile updated succesfully"    
        else
        flash[:notice] = @user.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
        end
    end

    def friends
        @friends = logged_user.friends
        @friend = @friends.find_by(id: params[:user_id])
    end
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.expect(user: [ :username, :password, :password_confirmation, :avatar, :email ] )
    end

    def edit_user_params
        params.expect(user: [ :username, :avatar ] )
    end

    def get_name(user_1, user_2)
        users = [user_1, user_2].sort
        "private_#{users[0].id}_#{users[1].id}"
    end

     def check_user
        if @user == logged_user
           redirect_to root_path, alert: "You can't chat with yourself." and return
        end
    end

    def authorize_friendship    
        return if logged_user.friends.exists?(@user.id)
        redirect_to root_path, alert: "You are not friends."
    end

    def deny_entrance
        unless @user == logged_user
            redirect_to root_path, alert: "You are not allowed to do that"
        end
    end

    def check_logged_user
        if logged_user.present?
            redirect_to root_path, alert: "You are already logged in"
        end
    end

    def check_blocked_user
        @invitation = Invitation.where("user_id=? OR friend_id=? OR username=?", logged_user.id, logged_user.id, logged_user.username).first
        if (@invitation.status == "blocked" && @invitation.user_id == logged_user.id) || (@invitation.status_invited == "blocked_invited" && @invitation.friend_id == logged_user.id)
            redirect_to_friends("This user is blocked")
        elsif (@invitation.friend_id == logged_user.id && @invitation.status == "blocked") || (@invitation.user_id == logged_user.id && @invitation.status_invited == "blocked_invited")
            redirect_to_friends("You have been blocked by this user")
        end
    end

    def redirect_to_friends(alert)
        redirect_to friends_users_path, alert: alert
    end
end
