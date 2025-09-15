require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user, username: "Mike", password: "123") }
  before do
    request_log_in(username: "Mike", password: "123")
  end

  describe "GET new" do
     it "should redirect to root_path if user is logged in" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    it "should create session" do
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Welcome/)
    end
  end

  describe "DELETE destroy" do
    it "should delete session" do
      delete logout_path
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(flash[:notice]).to include("Logged out")
    end
  end
end
