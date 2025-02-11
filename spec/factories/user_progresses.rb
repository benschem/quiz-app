FactoryBot.define do
  factory :user_progress do
    quiz { nil }
    current_question { nil }
    completed { false }
    session_id { SecureRandom.uuid }

    trait :complete do
      completed { true }
    end

    trait :incomplete do
      completed { false }
    end

    factory :complete_user_progress, traits: [:complete]
    factory :incomplete_user_progress, traits: [:incomplete]
  end
end
