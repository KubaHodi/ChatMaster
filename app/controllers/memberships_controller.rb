class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def show
    @invitation = Invitation.where("user_id=? OR friend_id=? OR username=?", logged_user.id, logged_user.id, logged_user.username).first
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
        invitation.update!(status: 1, status_invited: 1)
        redirect_to friends_users_path, alert: "You are friends now!"
      else
        Rails.logger.error membership.errors.full_messages.to_sentence
      end
  end

  def block
    if @invitation = Invitation.find_by(user_id: params[:user_id])
      if @invitation.user_id != logged_user.id
        @invitation.blocked_by = "inviter"
        @invitation.status = 3
        user = User.find_by(id: @invitation.user_id)
        debugger
            redirect_to friends_users_path, alert: "Successfully blocked user"
      else
        @invitation.blocked_by = "invited"
          @invitation.status_invited = 3
          debugger
            redirect_to friends_users_path, alert: "Successfully blocked user"
      end
    else @invitation = Invitation.find_by(friend_id: params[:user_id])
      debugger
    end
  end

  def unblock
     @invitation = Invitation.where("user_id=? OR friend_id=? OR username=?", logged_user.id, logged_user.id, logged_user.username).first
     user = @invitation.username
    if @invitation.user_id == logged_user.id
        @invitation.status = 1
          if @invitation.update(
            username: user
          )
          redirect_to friends_users_path, alert: "Successfully unblocked user"
          end
    else
        @invitation.status_invited = 1
          if @invitation.update(
            username: user
          )
          redirect_to friends_users_path, alert: "Successfully unblocked user"
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
