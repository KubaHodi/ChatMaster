RSpec.shared_examples "navbar present" do
    it "displays the navbar" do
        expect(page).to have_selector("nav.navbar")
    end

    it "should logout user" do
        click_on "logout"
        expect(response).to redirect_to login_path
    end
end