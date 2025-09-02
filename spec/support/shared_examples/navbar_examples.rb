RSpec.shared_examples "navbar present" do
    it "displays the navbar" do
        expect(page).to have_selector("nav.navbar")
    end
end