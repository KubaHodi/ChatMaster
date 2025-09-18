class UserMailer < ApplicationMailer
    def reset_password 
        @user = params[:user]

        raise ArgumentError, "User has no email" if @user.email.blank?

        @token = @user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)
        mail to: @user.email, subject: "Reset password" 
    end
end
