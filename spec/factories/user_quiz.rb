FactoryBot.define do
  factory :user_quiz do
    association :quiz
    association :user
  end
end
