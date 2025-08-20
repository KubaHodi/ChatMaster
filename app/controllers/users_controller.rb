class UsersController < ApplicationController
    skip_before_action :authorize

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to login_path, notice: "Successfully created user"}
                format.json { render :show, status: :created, location: @user }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def set_user
        @user = User.find(params.expect[:id])
    end

    def user_params
        params.expect(user: [ :username, :password, :password_confirmation, :avatar ] )
    end
end
