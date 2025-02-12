FactoryBot.define do
  factory :user do
    session_id { SecureRandom.uuid }
  end
end
