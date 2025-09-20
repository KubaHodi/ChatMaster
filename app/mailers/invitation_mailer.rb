class InvitationMailer < ApplicationMailer
    def send_invitation(invitation)
        @invitation = invitation
        username = @invitation.username
        user = User.find_by(username: username)
        mail to: user.email, subject: "You have been invited"      
    end
end
