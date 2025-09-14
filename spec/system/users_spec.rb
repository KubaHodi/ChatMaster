RSpec.describe "Users", type: :system do 
  let!(:user) { User.create!(username: "Dave", password: "123") }

  before do
    User.create!(username: "Jerry", password: "123")
  end
  it "displays register form" do
    visit register_path
    expect(page).to have_content(/REGISTER/)
  end
  it "registers new user" do
    system_register("Dave_2")
  end
  it "list all users in index" do
    system_log_in(user)
    click_on "Join users"
    visit users_path
    expect(page.body).to match(/Jerry/)
  end

  it "should show user" do
    system_log_in(user)
    click_on "Join users"
    click_on "Jerry"
    visit user_path("Jerry")
    expect(page.body).to match(/Jerry/)
  end

  it "should sent message to user and create private room" do
    system_log_in(user)
    click_on "Join users"
    click_on "Jerry"
    room_name = "private_room"
    room = Room.create_private_room([user, User.find_by(username: "Jerry")], room_name)
    post room_messages_path(room), params: {content: "Hello"}
    expect(page.body).not_to have_text(room_name)
  end

  it_behaves_like "navbar present", js: true do
    before { system_log_in(user) }
  end

end
