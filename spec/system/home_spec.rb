RSpec.describe "Home", type: :system do
    it "displays users and rooms count" do
        users = []
        rooms = []
        3.times do |k|
            user = User.create!(username: "Kuba#{k}", password: "123")
            room = Room.create!(name: "Room#{k}")
            users << user
            rooms << room
        end        
        system_log_in(users.first)   
        expect(page).to have_content(users.count)
        expect(page).to have_content(rooms.count)
        
        
    end
    it_behaves_like "navbar present"
end