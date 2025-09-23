class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def show
    @invitation = Invitation.find_by(user_id: params[:user_id], friend_id: logged_user.id)
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
        invitation.update!(status: 1)
        redirect_to friends_users_path, alert: "You are friends now!"
      else
        Rails.logger.error membership.errors.full_messages.to_sentence
      end
  end

  def update
    @invitation = Invitation.find_by(user_id: params[:user_id], friend_id: logged_user.id)
  end

  def delete
  end
  private

  def membership_params
    params.expect(membership: [ :user_id, :invitation_id ])
  end
end
