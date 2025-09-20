class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def show
  end

  def create
    invitation = Invitation.find(params[:invitation_id])

    if logged_user.id == invitation.user_id
      return redirect_to root_path, alert: "You can't accept your own invitation!"
    end

    membership = invitation.memberships.find_or_initialize_by(
      user: logged_user
    )
      if membership.save
        redirect_to friends_users_path
        invitation.accepted!
      else
        Rails.logger.error membership.errors.full_messages.to_sentence
      end
  end

  def delete
  end
  private

  def membership_params
    params.expect(membership: [ :user_id, :invitation_id ])
  end
end
