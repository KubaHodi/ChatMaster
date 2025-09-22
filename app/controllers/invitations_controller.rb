class InvitationsController < ApplicationController
    before_action :normalize_user_invites, only: %w[ create ]
    def new
        @invitation = Invitation.new
        @invitation_link = Invitation.new
    end

    def create
            target_user = User.find_by(
                username: params[:invitation][:username]
            )
            @invitation = Invitation.new(
                user: logged_user,
                friend: target_user,
                status: 0
            )
            @invitation.token = @invitation.generate_token
            if @invitation.save
                InvitationMailer.send_invitation(@invitation).deliver_later
                redirect_to root_path, alert: "Invitation had been sent"
            else
                render :new, status: 422
            end
    end

    def create_using_link
        @invitation_link = Invitation.new(
            user: logged_user,
            token: @invitation_link.generate_token
        )
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
        params.require(:invitation).permit(:username, :friend_id, :token, :user)
    end

    def normalize_user_invites
        target_username = params.dig(:invitation, :username)
        return unless target_username.present?

        target_user = User.find_by(username: target_username)

        if target_user == logged_user
            redirect_to root_path
        end
        
        if !target_user.nil?
            if Invitation.exists?(
                user_id: logged_user.id,
                friend_id: target_user.id,
                status: 1
            ) || 
            Invitation.exists?(
                user_id: target_user.id,
                friend_id: logged_user.id,
                status: 1
            )
            redirect_to(root_path, alert: "You are already friends") and return
            end
            if Invitation.exists?(
                user_id: logged_user.id,
                friend_id: target_user.id,
                status: 0
            )
                redirect_to(root_path, alert: "You already invited this user") and return
            end

            if Invitation.exists?(
                user_id: target_user&.id,
                friend_id: logged_user.id,
                status: 0
                
            )
                redirect_to(root_path, alert: "You have pending friend request from this user") and return
            end
        else 
        redirect_to invite_path, notice: "This username does not exist"
        end
    end
end