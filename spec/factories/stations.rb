FactoryBot.define do
  factory :station do
    name 'Station Name'

    trait :invalid do
      name nil
    end
  end
end
