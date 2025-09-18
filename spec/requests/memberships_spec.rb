require 'rails_helper'

RSpec.describe "Memberships", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/memberships/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/memberships/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/memberships/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/memberships/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
