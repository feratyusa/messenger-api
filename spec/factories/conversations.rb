FactoryBot.define do
  factory :conversation do
    name { Faker::Alphanumeric.alpha(number: 10) }
  end
end
