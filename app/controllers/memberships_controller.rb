class MembershipsController < ApplicationController
  helper_method :logged_user
  def new
    @membership = Membership.new
  end

  def show
  end

  def create
    invitation = Invitation.find(params[:invitation_id])
    id = invitation.user_id

    membership = Membership.find_or_initialize_by(
      user_id: logged_user.id,
      invitation_id: id
    )
    if logged_user.id == id
      redirect_to root_path, alert: "You can't accept your own invitation!"
    else
      if membership.save
        redirect_to users_path
      else
        redirect_to root_path
      end
    end
  end

  def delete
  end

  private

  def membership_params
    params.expect(membership: [ :user_id, :invitation_id ])
  end
end
