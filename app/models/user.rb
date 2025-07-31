class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  scope :all_except, -> (user) { where.not(id: user) } #zakres umożliwiający pobranie wszystkich użytkowników z wyjątkiem samego siebie
  has_secure_password
end
