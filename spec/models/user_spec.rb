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

  it "is invalid if the username is already taken" do
    described_class.create!(username: "Mike", password: "321", password_confirmation: "321")
    duplicate_user = described_class.new(username: "Mike", password: "123", password_confirmation: "123")
    expect(duplicate_user).to_not be_valid
  end
  
  it "is valid if the username is unique" do
    described_class.create!(username: "Mike", password: "123", password_confirmation: "123")
    unique_user = User.new(username: "Thomas", password: "123", password_confirmation: "123")
    expect(unique_user).to be_valid
  end

  it "has password confirmation" do
    user =  described_class.new(username: "John", password: "123", password_confirmation: "321")
    expect(user).to_not be_valid
  end
end
