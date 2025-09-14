RSpec.describe "Home", type: :system do
    let!(:users) { Array.new(3) { |k| User.create!(username: "Kuba#{k}", password: "123") } }
    let!(:rooms) { Array.new(3) { |k| Room.create(name: "Room#{k}") } }
    before do
        system_log_in(users.first)
    end
    it "displays users and rooms count" do       
        expect(page).to have_content(users.count)
        expect(page).to have_content(rooms.count)
    end
    it_behaves_like "navbar present", js: true
end