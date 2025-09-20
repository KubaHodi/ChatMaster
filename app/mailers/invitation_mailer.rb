class InvitationMailer < ApplicationMailer
    def send_invitation(invitation)
        @invitation = invitation
        user = User.find_by(params[:username])
        mail to: user.email, subject: "You have been invited"      
    end
end
