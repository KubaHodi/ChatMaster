require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build(:message) }

  it "is not valid without content" do
    subject.content = nil
    expect(subject).not_to be_valid
  end

  describe "#confirm_participant" do
    let(:users) { create_list(:user, 2) }
    let(:room_name) { "Secret Room" }
    it "should confirm participant if room is private" do
      room = Room.create_private_room(users, room_name)
      expect(room).to be_persisted
    end
  end
end
