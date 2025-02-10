FactoryBot.define do
  factory :question do
    association :quiz
    text { "sample question?" }
  end
end
