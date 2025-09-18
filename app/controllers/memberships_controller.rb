class MembershipsController < ApplicationController
  helper_method :logged_user
  def new
    @membership = Membership.new
  end

  def show
  end

  def create
    invitation = Invitation.find(params[:invitation_id])
    membership = (logged_user.memberships.build(invitation: invitation))

    if membership.save
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def delete
  end

  private

  def membership_params
    params.expect(membership: [ :user_id, :invitation_id ])
  end
end
