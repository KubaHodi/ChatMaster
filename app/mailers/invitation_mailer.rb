class InvitationMailer < ApplicationMailer
    def send_invitation(invitation)
        @invitation = invitation
        mail to: @invitation.email, subject: "You have been invited"      
    end
end
