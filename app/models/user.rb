class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  scope :all_except, ->(user) { where.not(id: user) } #zakres umożliwiający pobranie wszystkich użytkowników z wyjątkiem samego siebie
  has_secure_password

  def self.ransackable_attributes(auth_object = nil)
    %w[ username ]
  end
end
