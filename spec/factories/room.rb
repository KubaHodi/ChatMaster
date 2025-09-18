FactoryBot.define do
    factory :room do
        name { "Music_#{SecureRandom.hex(3)}" }
        is_private { false }
    end
end