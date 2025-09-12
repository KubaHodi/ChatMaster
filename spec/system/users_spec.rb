RSpec.describe "Users", type: :system do 
  let!(:user) { create(user: "Dave", password: "123") }
  it "displays register form" do
    visit register_path
    expect(page).to have_content(/REGISTER/)
  end
  it "registers new user" do
    system_register("Dave")
    post register_path
    expect(page.body).to match(/Successfully created user/)
  end
  it "list all users in index" do
    system_log_in("Dave")
    expect(page.body).to match(/Dave/)
  end
end
