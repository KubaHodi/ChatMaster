class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def show
  end

  def create
    @membership = Membership.new(
      user_id: logged_user,
      invitation_id: session[:user_id]
    )
    if @membership.save
      redirect_to users_path, notice: "You accepted friend request"
    else
      redirect_to users_path
    end
  end

  def delete
  end

end
