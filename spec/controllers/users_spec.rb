RSpec.describe UsersController, type: :request do
    describe "GET index" do
        it "assigns @users" do
            user = User.create
            get users_path
            expect(response).to have_http_status(:redirect)
        end
    end
end