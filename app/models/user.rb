class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  scope :all_except, ->(user) { where.not(id: user) } #zakres umożliwiający pobranie wszystkich użytkowników z wyjątkiem samego siebie
  has_secure_password
  has_one_attached :avatar
  after_create_commit { broadcast_append_to "users" } #Po utworzeniu użytkownika przesyłamy partial _user i dołączamy go do diva gdzie są wyświetlani użytkownicy id="users" oraz używamy turbo_stream from "users" aby odebrać ten przesył

    def self.ransackable_attributes(auth_object = nil)
      %w[ username ]
    end
end
