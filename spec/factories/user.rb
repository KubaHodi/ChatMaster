FactoryBot.define do
    factory :user do
        username { "Mike" }
        password { "123" }
        password_confirmation { "123" }
    end
end