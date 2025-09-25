class Profile < ApplicationRecord
    enum :status, { public_profile: 0, private_profile: 1 }
    belongs_to :user
    validates :user_id, presence: true
end
