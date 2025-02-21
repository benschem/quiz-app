FactoryBot.define do
  factory :guess do
    association :user
    association :answer
    association :user_quiz
  end
end
