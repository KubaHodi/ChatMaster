class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, uniqueness: true
  scope :all_except, ->(user) { where.not(id: user) } #zakres umożliwiający pobranie wszystkich użytkowników z wyjątkiem samego siebie

  has_secure_password
  has_many :messages
  has_one_attached :avatar

  after_create_commit { broadcast_append_to "users" } #Po utworzeniu użytkownika przesyłamy partial _user i dołączamy go do diva gdzie są wyświetlani użytkownicy id="users" oraz używamy turbo_stream from "users" aby odebrać ten przesył
  after_create_commit :add_default_avatar
  
  def self.ransackable_attributes(auth_object = nil)
    %w[ username ]
  end

  private
  def add_default_avatar
    return if avatar.attached?
    avatar.attach(
      io: File.open(Rails.root.join("app/assets/images/default_avatar.png")),
      filename: "default_avatar.png",
      content_type: "image/png"
    )
  end
end
