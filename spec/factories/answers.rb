FactoryBot.define do
  factory :answer do
    question { nil }
    text { "MyString" }
    correct { false }
    times_guessed { 1 }
  end
end
