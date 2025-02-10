FactoryBot.define do
  factory :answer do
    association :question
    text { "sample answer" }
    correct { false }
    times_guessed { 0 }
  end
end
