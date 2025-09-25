class InvitationsController < ApplicationController
    before_action :normalize_user_invites, only: %w[ create destroy ]
    def new
        @invitation = Invitation.new
    end

    def create
        case params[:form_type]
        when "username"
            target_user = User.find_by(
                username: params[:invitation][:username]
            )
            @invitation = Invitation.new(
                user: logged_user,
                friend: target_user,
                status: 0
            )
            @invitation.token = @invitation.generate_token
            @invitation.mode = :by_username
            if @invitation.save
                InvitationMailer.send_invitation(@invitation).deliver_later
                redirect_to root_path, alert: "Invitation had been sent"
            else
                render :new, status: 422
            end
        when "link"
            @invitation = Invitation.new(
                user: logged_user
            )
            @invitation.mode = :by_link
            @invitation.token = @invitation.generate_token
            link = Invitation.where(user_id: logged_user.id, username: nil)
            if link.count >= 1
                redirect_to root_path, alert: "You already have your unique token!"
            else
                if @invitation.save
                    redirect_to user_invite_path, alert: "Your link had been stored!"
                end
            end
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

    def destroy
        @invitation = Invitation.find_by(token: params[:token])
        if @invitation
            @invitation.destroy
            redirect_to user_invite_path, alert: "Successfully deleted pending invitation"
        else
            redirect_to user_invite_path, alert: "Couldn't delete invitation"
        end
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
            redirect_to user_invite_path, alert: "You can't invite yourself"
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
            redirect_to(user_invite_path, alert: "You are already friends") and return
            end
            if Invitation.exists?(
                user_id: logged_user.id,
                friend_id: target_user.id,
                status: 0
            )
                redirect_to(user_invite_path, alert: "You already invited this user") and return
            end

            if Invitation.exists?(
                user_id: target_user&.id,
                friend_id: logged_user.id,
                status: 0
                
            )
                redirect_to(user_invite_path, alert: "You have pending friend request from this user") and return
            end
        else 
        redirect_to user_invite_path, notice: "This username does not exist"
        end
    end
end