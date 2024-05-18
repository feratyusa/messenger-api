FactoryBot.define do
  factory :text do
    message { Faker::Lorem.paragraph }
    user
    conversation
  end
end
