FactoryBot.define do
  factory :station_form do
    name 'Station Name'
    street '100 Main Street'
    city 'Chattanooga'
    state 'TN'
    zip '10101'

    trait :no_street_address do
      street nil
      city nil
      state nil
      zip nil
    end

    trait :no_coordinate_pair do
      latitude nil
      longitude nil
    end

    trait :invalid_station do
      name nil
    end

    trait :invalid_address do
      street nil
      city nil
      state nil
      zip 0
    end

    trait :invalid do
      invalid_address
      invalid_station
    end
  end
end
