FactoryBot.define do
  factory :text do
    message { Faker::Lorem.paragraph }
    conversation
  end
end
