require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  let(:profile) {
    Profile.create!()
  }

  before(:each) do
    assign(:profile, profile)
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", profile_path(profile), "post" do
    end
  end
end
