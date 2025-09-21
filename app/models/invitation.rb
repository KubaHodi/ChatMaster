class Invitation < ApplicationRecord
    enum :status, { pending: 0, accepted: 1, declined: 2 }

    belongs_to :user
    belongs_to :friend, class_name: "User"
    
    validates :username, presence: true, uniqueness: { scope: :user_id, condition: -> { where(status: "0") }, message: "has already been invited"}
    validates :user_id, :friend_id, presence: true
    validates :token, presence: true, uniqueness: true
    
    has_many :memberships
    before_create :generate_token
    after_create :schedule_expiration
    before_validation :copy_username_from_friend
    scope :expired, -> { where("status = ? AND created_at < ?", 0, 2.minutes.ago) }

    def generate_token
        self.token = SecureRandom.urlsafe_base64(16)
    end

    private
    def schedule_expiration
        PendingInvitationsCleanupJob.set(wait: 15.minutes).perform_later(self.id)
    end

    def copy_username_from_friend
        self.username ||= friend&.username
    end
end
