FactoryBot.define do
  factory :question do
    association :quiz
    text { "question?" }
    number { 1 }

    trait :with_answers do
      after(:create) do |question|
        create(:correct_answer, question: question)
        create(:incorrect_answer, question: question)
      end
    end

    factory :question_with_answers, traits: [:with_answers]
  end
end
