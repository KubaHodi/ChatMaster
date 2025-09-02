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
    user = User.new(username: "Mike1", password_digest: "123")
    if user[:username] == subject.username
      expect(subject).to_not be_valid
    else
      expect(subject).to be_valid
    end    
  end
  
  it "has password confirmation" do
    subject.password_confirmation = "123"
    expect(subject.password_confirmation).to match(subject.password)
  end
end
