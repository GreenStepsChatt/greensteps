FactoryBot.define do
  factory :station_form do
    name 'Station Name'
    street '100 Main Street'
    city 'Chattanooga'
    state 'TN'
    zip '10101'

    trait :invalid_station do
      name nil
    end

    trait :invalid_address do
      street nil
    end

    trait :invalid do
      invalid_address
      invalid_station
    end
  end
end
