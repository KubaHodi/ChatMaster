require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  before(:each) do
    assign(:profile, Profile.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
