class SecureInfoController < ApplicationController
  def index
    if logged_user&.authenticate(params[:password])
      redirect_to secure_info_show_path
    end
  end

  def show
      @invitation = Invitation.find_by(user_id: logged_user.id, username: nil)
  end
end
