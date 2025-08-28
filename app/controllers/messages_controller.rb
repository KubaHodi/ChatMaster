class MessagesController < ApplicationController
    def create
        @user = logged_user
        @message =  @user.messages.create(content: message_params[:content], room_id: params[:room_id])
    end

    private

    def message_params
        params.expect(message: [ :content ])
    end
end