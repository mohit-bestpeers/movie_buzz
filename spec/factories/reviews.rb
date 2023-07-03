FactoryBot.define do
  factory :review do
    star { 5 }
    body {"hfjsfs"}
    association :movie
    association :user
  end
end
