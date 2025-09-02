require "rails_helper"

RSpec.describe Room, type: :model do
    subject { build(:room) }
    
    it "is not valid without name" do
        subject.name = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without unique name" do
        create(:room, name: "Music")
        subject.name = "Music"
        expect(subject).not_to be_valid
    end

    describe "#broadcast_if_public" do
        it "should only broadcast to public rooms" do         
            expect(subject).to receive(:broadcast_if_public)
            subject.save
        end
    end

    describe "should #create_private_room" do
        let(:users) { create_list(:user, 2) }
        let(:room_name) { "Secret Room" }
        it "creates private room with given name" do
            room = Room.create_private_room(users, room_name)

            expect(room).to be_persisted
            expect(room.name).to eq(room_name)
            expect(room.is_private).to be true
        end

        it "creates participants for all users" do
            room = Room.create_private_room(users, room_name)

            expect(room.participants.count).to eq(users.count)
            users.each do |user|
                expect(room.participants.pluck(:user_id)).to include(user.id)
            end
        end

        it "return the created room" do
            room = Room.create_private_room(users, room_name)
            expect(room).to be_a(Room)
            expect(room_name).to eq(room_name)
        end
    end
end