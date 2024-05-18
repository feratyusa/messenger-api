FactoryBot.define do
  factory :unread do
    user_id { Faker::Number.between(from: 1, to: 10) }
  end
end
