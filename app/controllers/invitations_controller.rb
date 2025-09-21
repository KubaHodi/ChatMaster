class InvitationsController < ApplicationController
    before_action :normalize_user_invites, only: %w[ create ]
    def new
        @invitation = Invitation.new
    end

    def create
        @invitation = Invitation.new(invitation_params)
        @invitation.user = logged_user
        @invitation.token = @invitation.generate_token
        user = User.find_by(username: @invitation.username)
        if user.id != logged_user.id
            if @invitation.save
                InvitationMailer.send_invitation(@invitation).deliver_later
                redirect_to root_path, alert: "Invitation had been sent"
            else
                render :new, status: 422
            end
        else
            redirect_to root_path, alert: "You can't invite yourself"
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

    def normalize_user_invites
        target_username = params.dig(:invitation, :username)
        return unless target_username.present?

        target_user = User.find_by(username: target_username)

        if Invitation.exists?(
            user_id: logged_user.id,
            username: target_username,
            status: 0
        )
            redirect_to(root_path, alert: "You already invited this user") and return
        end

        if Invitation.exists?(
            user_id: target_user&.id,
            username: logged_user.username,
            status: 0
            
        )
            redirect_to(root_path, alert: "You have pending friend request from this user") and return
        end
    end
end