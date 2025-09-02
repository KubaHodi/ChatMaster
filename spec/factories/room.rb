FactoryBot.define do
    factory :room do
        sequence(:name) { |n| "Music_#{n}"}
        is_private { false }
    end
end