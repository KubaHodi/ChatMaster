require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let!(:user) { create(:user, username: "Mike", password: "123") }
  describe "GET index" do
    it "gets users from search" do
      get search_path, params: { query: "M" }
    end
  end
end
