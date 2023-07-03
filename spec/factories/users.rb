FactoryBot.define do
  factory :user do
    name {"mohit"}
    sequence(:email) { |n| "movie#{n}@example.com" }
    password {"12345678"}
    role {"admin"}
  end
end