class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  scope :all_except, ->(user) { where.not(id: user) } #zakres umożliwiający pobranie wszystkich użytkowników z wyjątkiem samego siebie
  has_secure_password
  has_one_attached :avatar
  after_create_commit { broadcast_append_to "users" }

    def self.ransackable_attributes(auth_object = nil)
      %w[ username ]
    end
end
