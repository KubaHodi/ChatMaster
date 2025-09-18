RSpec.shared_examples "new message form present" do
    it "displays the new message form" do
        expect(page).to have_selector("new_message_form")
    end
end