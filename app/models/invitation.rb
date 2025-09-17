class Invitation < ApplicationRecord
    belongs_to :user
    belongs_to :invite, class_name: "User", optional: true

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :token, presence: true, uniqueness: true

    before_create :generate_token
    
    private

    def generate_token
        self.token = SecureRandom.urlsafe_base64(16)
    end
end
