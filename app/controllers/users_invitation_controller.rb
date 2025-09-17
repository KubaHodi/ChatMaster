class UsersInvitationController < Devise::InvitationsController
    respond_to :json
    
    def create
        new_user = User.invite!(invite_params)
        if new_user.valid?
            render json: new_user, status: :ok
        else
            render json: { error: new_user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        new_user = User.accept_invitation!(
        invitation_token: params[:user][:invitation_token],
        username: params[:user][:username],
        password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation]
        )

        if new_user.valid?
            session[:user_id] = new_user.id
            render json: new_user, status: :ok
        else
            render json: { errors: new_user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def invite_params
        params.permit(:email, :group_id, :invitation_token)
    end
end
