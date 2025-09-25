class Profile < ApplicationRecord
    has_one :user
    validates :user, presence: true
end
