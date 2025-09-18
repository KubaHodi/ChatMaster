require "rails_helper"

RSpec.describe UsersController, type: :request do
    let!(:user) { create(:user, username: "Mike", password: "123") }
    let!(:room) { create(:room, name: "room") }
    before do
        request_log_in(username: "Mike", password: "123")
    end
    describe "GET index" do
        it "assigns @users" do
            get users_path
            expect(response).to have_http_status(:ok)
        end
    end

    describe "GET show" do
       
        it "redirects to current room" do
            get user_path(user)
            expect(response).to have_http_status(200)
            expect(response.body).to match (/Mike/)
        end

        it "shows current user" do
            get user_path(user)
            expect(response.body).to match (/Mike/)
        end
    end

    describe "POST create" do
        it "redirects to register form" do
            get register_path
            expect(response).to have_http_status(200)
            expect(response.body).to match(/REGISTER|Please enter your login and password|Username|Password|Password confirmation/)
        end

        it "creates user" do
        expect{
            post register_url, params: { user: { username: "Rick", password: "123", password_confirmation: "123" } }         
        }.to change{ User.count }.by(1)
        expect(response).to redirect_to login_path
        end
    end
end