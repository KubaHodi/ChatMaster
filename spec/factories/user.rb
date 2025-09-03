FactoryBot.define do
    factory :user do
        sequence(:username) { |n| "Mike_#{n}"}
        password { "123" }
        password_confirmation { "123" }
    end
end