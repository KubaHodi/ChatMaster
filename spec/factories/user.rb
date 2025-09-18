FactoryBot.define do
    factory :user do
        username { "Mike_#{SecureRandom.hex(3)}" }
        email { "mike#{SecureRandom.hex(3)}@gmail.com" }
        password { "123" }
        password_confirmation { "123" }
    end
end