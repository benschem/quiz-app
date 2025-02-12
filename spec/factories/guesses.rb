FactoryBot.define do
  factory :guess do
    association :user
    association :answer
  end
end
