require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it "is not valid without username" do
    subject.username = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without password" do
    subject.password = nil
    expect(subject).not_to be_valid
  end

  it "is invalid if the username is already taken" do
    create(:user, username: "Mike")
    subject.username = "Mike"
    expect(subject).not_to be_valid
  end
  
  it "is valid if the username is unique" do
    create(:user, username: "Mike_2")
    subject.username = "Mike"
    expect(subject).to be_valid
  
  end

  it "has password confirmation" do
    subject.password = "123"
    subject.password_confirmation = "321"
    expect(subject).not_to be_valid
  end
end
