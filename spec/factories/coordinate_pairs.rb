FactoryBot.define do
  factory :coordinate_pair do
    latitude(32.553985)
    longitude(-83.668272)

    association :locateable, factory: :station

    trait :invalid do
      latitude nil
      longitude nil
    end
  end
end
