require 'rails_helper'

RSpec.describe "SecureInfos", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/secure_info/index"
      expect(response).to have_http_status(:success)
    end
  end

end
