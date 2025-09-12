require 'rails_helper'

RSpec.describe "Messages", type: :request do  
  let!(:room) { create(:room, name: "Vc") }
  let!(:message) { create(:message, content:"Hi") }
  let!(:user) { create(:user, username:"Mike", password: "123") }
  describe "POST create room/messages" do
    it "should create message with content" do
      post room_message_path, params: { message:, content: "Hi", room:, name:"Vc" }
      expect(response.body).to match(/Hi/)
    end
  end
end
