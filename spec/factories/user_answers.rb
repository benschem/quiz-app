FactoryBot.define do
  factory :user_answer do
    session_id { SecureRandom.uuid }
    association :answer
  end
end
