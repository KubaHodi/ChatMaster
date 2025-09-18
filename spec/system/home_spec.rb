RSpec.describe "Home", type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:room) { FactoryBot.create(:user)  }
    before do
        system_log_in(user)
    end
    it "displays users and rooms count" do       
        expect(page).to have_content(User.count)
        expect(page).to have_content(Room.count)
    end
    it_behaves_like "navbar present", js: true
end