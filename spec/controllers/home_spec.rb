RSpec.describe HomeController, type: :request do
    describe "GET /" do
        it "starts with home page" do
            get root_path
            expect(response).to have_http_status(:found)
        end
    end
end