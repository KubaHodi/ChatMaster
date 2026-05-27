class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: :true
  before_create :confirm_participant
  
  after_create_commit :broadcast_message

def broadcast_message
  broadcast_append_to(
    [room, "messages"],
    target: "messages",
    partial: "messages/message",
    locals: { message: self }
  )
end

  def confirm_participant
    if self.room.is_private
      is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless is_participant
    end
  end
end
