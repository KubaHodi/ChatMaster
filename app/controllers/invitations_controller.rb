class InvitationsController < ApplicationController
    before_action :find_invitation, only: %w[ show update ]
    def new
        @invitation = Invitation.new
    end

    def create
        @invitation = Invitation.new(invitation_params)
        @invitation.user_id = current_user.id

        if @invitation.save
            InvitationMailer.send_invitation(@invitation).deliver_now
            redirect_to root_path, notice: "Invitation had been sent"
        else
            render :new
        end
    end

    def show
        

    end

    def update
        if @invitation.update(accepted_at: Time.current)
        end
    end
end