class Invitation < ApplicationRecord
    validates :username, presence: true
    validates :token, presence: true, uniqueness: true

    belongs_to :user
    has_many :memberships
    before_create :generate_token

    def generate_token
        self.token = SecureRandom.urlsafe_base64(16)
    end
end
