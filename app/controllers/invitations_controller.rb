class InvitationsController < ApplicationController
    def new
        @invitation = Invitation.new
    end

    def create
        @invitation = Invitation.new(invitation_params)
        @invitation.user = logged_user
        @invitation.token = @invitation.generate_token
        if @invitation.save
            InvitationMailer.send_invitation(@invitation).deliver_later
            redirect_to root_path, alert: "Invitation had been sent"
        else
            render :new, status: 422
        end
    end

    def show
        @invitation = Invitation.find_by(token: params[:token])
    end

    def index
        @invitations = Invitation.where(status: 0, username: logged_user.username)
        @users_ids = @invitations.pluck(:user_id)
        @users = User.find(@users_ids)
    end

    def update
    end

    def delete
    end

    private
    
    def invitation_params
        params.expect(invitation: [:username, :user, :token])
    end
end