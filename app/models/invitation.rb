class Invitation < ApplicationRecord
    enum :status, { pending: 0, accepted: 1, declined: 2 }
    validates :username, presence: true, uniqueness: { scope: :user_id, condition: -> { where(status: "0") }, message: "has already been invited"}
    validates :token, presence: true, uniqueness: true
    belongs_to :user
    has_many :memberships
    before_create :generate_token
    after_create :schedule_expiration
    scope :expired, -> { where("status = ? AND created_at < ?", 0, 15.minutes.ago) }
    def generate_token
        self.token = SecureRandom.urlsafe_base64(16)
    end

    private
    
    def schedule_expiration
        PendingInvitationsCleanupJob.set(wait: 15.minutes).perform_later(self.id)
    end


end
