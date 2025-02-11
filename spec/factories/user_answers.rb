FactoryBot.define do
  factory :guess do
    session_id { SecureRandom.uuid }
    association :answer
  end
end
