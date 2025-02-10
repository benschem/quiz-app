FactoryBot.define do
  factory :answer do
    association :question
    text { "incorrect answer" }
    times_guessed { 0 }

    trait :correct do
      text { "correct answer" }
      correct { true }
    end

    trait :incorrect do
      text { "incorrect answer" }
      correct { false }
    end

    factory :correct_answer, traits: [:correct]
    factory :incorrect_answer, traits: [:incorrect]
  end
end
