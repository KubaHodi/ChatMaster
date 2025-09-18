class InvitationsController < ApplicationController
    before_action :find_invitation, only: %w[ show update ]
    def new
        @invitation = Invitation.new
    end

    def create
        @invitation = Invitation.new(invitation_params)
        @invitation.user = logged_user
        @invitation.token = @invitation.generate_token
        if @invitation.save
            InvitationMailer.send_invitation(@invitation).deliver_now
            redirect_to root_path, alert: "Invitation had been sent"
        else
            render :new, status: 422
        end
    end

    def show
        
    end

    def update
        if @invitation.update(accepted_at: Time.current)
        end
    end

    private
    
    def invitation_params
        params.expect(invitation: [:email, :user, :token])
    end
end