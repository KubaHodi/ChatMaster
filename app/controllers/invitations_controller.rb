class InvitationsController < ApplicationController
    skip_before_action :authorize, only: %w[ show ]
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
        @invitation = Invitation.find_by(token: params[:token])
    end

    def update
    end

    private
    
    def invitation_params
        params.expect(invitation: [:email, :user, :token])
    end
end