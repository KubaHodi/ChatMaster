require 'rails_helper'

RSpec.describe "Messages", type: :request do  
  before do
  @user = User.create!(username: "Jerry", password: "123")
  @room = Room.create!(name: "Vc")
  request_log_in(username: @user.username, password: "123")
  end

  describe "POST create room/messages" do
    it "should create message with content" do
    expect{
      post room_messages_path(@room), params: { message: { content: "Hi" } }
    }.to change{ Message.count }.by(1)
    end
  end
end
