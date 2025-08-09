class Room < ApplicationRecord
    validates :name, uniqueness: true
    scope :public_rooms, -> { where(is_private: false) }
end
