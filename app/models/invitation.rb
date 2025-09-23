class Invitation < ApplicationRecord
    enum :status, { pending: 0, accepted: 1, declined: 2, blocked: 3 }

    belongs_to :user
    belongs_to :friend, class_name: "User", optional: true
    has_many :memberships

    attr_accessor :mode
    with_options if: :by_username? do
        validates :username, presence: true, uniqueness: { scope: :user_id, condition: -> { where(status: "0") }, message: "has already been invited"}
        validates :user_id, :friend_id, presence: true  
    end
    with_options if: :by_link? do
        validates :token, presence: true, uniqueness: true
    end

    before_create :generate_token
    after_create :schedule_expiration
    before_validation :copy_username_from_friend, if: :by_username?
    scope :expired, -> { where("status = ? AND created_at < ?", 0, 2.minutes.ago) }

    def by_link? = mode.to_s == "by_link"
    def by_username? = mode.to_s == "by_username"

    def generate_token
        self.token = SecureRandom.urlsafe_base64(16)
    end

    private
    def schedule_expiration
        PendingInvitationsCleanupJob.set(wait: 6.hours).perform_now(self.id)
    end

    def copy_username_from_friend
        self.username ||= friend&.username
    end
end
