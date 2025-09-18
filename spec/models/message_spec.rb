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
    let(:room) { Room.create_private_room(users, room_name) }
      context "if user is a participant" do
        it "saves the message successfully" do
          message = Message.new(user: users.first, room: room, content: "hi")
          expect { message.save! }.not_to raise_error
          expect(message).to be_persisted
        end
      end

      context "when user is not a participant" do
        let(:outsider) { create(:user) }
        
        it "throws abort and does not save" do
          message = Message.new(user: outsider, room: room, content: "hello")
          expect { message.save! }.to raise_error(ActiveRecord::RecordNotSaved)
          expect(message).not_to be_persisted
        end
      end
  end
end
