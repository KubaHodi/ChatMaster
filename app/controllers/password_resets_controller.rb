class PasswordResetsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      UserMailer.with(user: @user).reset_password.deliver_later
    end

    redirect_to login_path, notice: "If an account with that email was foud. We are going to sent you a link to reset password"
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to login_path, alert: "You token has expired. Please try again"
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")

    if @user.update(password_params)
      redirect_to login_path, notice: "You password was reset successfully. You can now sign in."
    else
      render "edit"
    end

    rescue ActiveSupport::MessageVerifier::InvalidSignature
     redirect_to login_path, alert: "You token has expired. Please try again."
    
    rescue ActiveRecord
      redirect_to login_path, alert: "You link has expired."
  end

  private

  def password_params
    params.expect(user: [ :password, :password_confirmation ] )
  end

end
