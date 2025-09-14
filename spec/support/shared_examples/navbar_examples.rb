RSpec.shared_examples "navbar present" do
    it "displays the navbar and can logout" do
        expect(page).to have_selector("nav.navbar")
        click_on "logout"
        expect(page).to have_text("Logged out")
        expect(page).to have_button("Login")
    end
end