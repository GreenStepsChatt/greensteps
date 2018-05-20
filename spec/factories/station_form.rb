FactoryBot.define do
  factory :station_form do
    name { Faker::Address.community }
    street '1800 Polk St.'
    city 'Chattanooga'
    state 'TN'
    zip '37408'

    trait :with_coords_only do
      no_street_address
      with_coords
    end

    trait :with_coords do
      latitude { Faker::Number.between(34.952750, 35.223899).round(6) }
      longitude { Faker::Number.between(-85.550085, -85.031483).round(6) }
    end

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
