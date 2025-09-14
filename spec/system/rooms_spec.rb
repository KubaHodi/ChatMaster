RSpec.describe "Rooms", type: :system do
  let!(:user) { User.create!(username: "Jimmy", password: "123") }
  before do
    system_log_in(user)
    Room.create!(name: "VC", is_private: false)
    Room.create!(name: "private_room", is_private: true)
    click_on "Join rooms"
    visit rooms_path
  end
  it "should display all public rooms" do
    expect(page.body).to have_content(/Avaiable rooms|VC/)
  end

  it "should not display private rooms" do
    expect(page.body).not_to have_content(/private_room/)
  end

  it "should display form" do
    expect(page.body).to have_content(/Create new room|Create Room/)
  end
  
  it "should create new room" do
    fill_in "room_name", with: "Gaming"
    click_on "Create Room"
    visit rooms_path
    expect(page.body).to have_content(/Gaming/)
  end

  it "should show room" do
    click_on "VC"
    expect(page.body).to have_content(/VC/)
  end

  it "should create message in room" do
    click_on "VC"
    fill_in "text-message", with: "Hi"
    click_on "Create Message"
    visit room_path(Room.find_by(name:["VC"]))
    expect(page.body).to have_content(/Hi/)
    expect(page.body).to have_css(".mine")
  end
  it_behaves_like "navbar present", js: true
end
