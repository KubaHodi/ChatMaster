require 'rails_helper'

RSpec.describe RoomsController, type: :request do
  let!(:user) { create(:user, username: "Mike", password: "123") }
  let!(:room) { create(:room, name: "Vc")}

  before do
    request_log_in(username: "Mike", password: "123")
    Room.create!(name: "Music")
    Room.create!(name: "Gaming", is_private: true)
  end

  describe "GET index" do
    it "should get all public rooms" do
      get rooms_path, as: :turbo_stream
      expect(response).to have_http_status(200)
      expect(response.body).to match(/Music/)
    end
    it "should not get private rooms" do
      get rooms_path, as: :turbo_stream
      expect(response.body).not_to match(/Gaming/)
    end
  end

  describe "POST create" do
    it "should create room" do
      expect{
        post rooms_path, params: { room: { name: "room_2"} } 
      }.to change{ Room.count }.by(1), as: :turbo_stream
      expect(response).to redirect_to rooms_path
    end

    it "should not create room without params" do
      expect{
        post rooms_path, params: {room: { name: "" } }
      }.to change{ Room.count }.by(0)
    end
  end

  describe "GET show" do
    it "should redirect to current room" do
      get rooms_path(room)
      expect(response).to have_http_status(200)
      expect(response.body).to match(/#{room.name}/)
    end
  end

end
