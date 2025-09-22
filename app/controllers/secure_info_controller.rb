class SecureInfoController < ApplicationController
  def index
    @invitation = Invitation.find_by(user: logged_user)
  end
end
