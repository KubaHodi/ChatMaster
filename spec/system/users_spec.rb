RSpec.describe "Users", type: :system do 
  let!(:user) { User.create!(username: "Dave", password: "123") }
  it "displays register form" do
    visit register_path
    expect(page).to have_content(/REGISTER/)
  end
  it "registers new user" do
    system_register("Dave_2")
  end
  it "list all users in index" do
    User.create!(username: "Jerry", password: "123")
    system_log_in(user)
    click_on "Join users"
    visit users_path
    expect(page.body).to match(/Jerry/)
  end

  it "should show user" do
    User.create!(username: "Jerry", password: "123")
    system_log_in(user)
    click_on "Join users"
    click_on "Jerry"
    visit user_path("Jerry")
    expect(page.body).to match(/Jerry/)
  end
  it_behaves_like "navbar present"
end
