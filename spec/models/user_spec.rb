require 'rails_helper'

RSpec.describe User, type: :model do
  subject { 
    described_class.new(
      username: "Mike",
      password: "123",
    )
   } 
  it "is not valid without username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "does not have the same username" do
    user = User.new(username: "Mike", password_digest: "123")
    expect(subject[:username]).to match(user[:username])
  end
  
  it "has password confirmation" do
    subject.password_confirmation = "123"
    expect(subject.password_confirmation).to match(subject.password)
  end
end
