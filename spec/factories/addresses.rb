FactoryBot.define do
  factory :address do
    street '101 Main Street'
    city 'Chattanooga'
    state 'TN'
    zip 10101 # rubocop:disable Style/NumericLiterals

    association :addressable, factory: :station

    trait :no_street_address do
      street nil
      city nil
      state nil
      zip nil
    end

    trait :no_coordinates do
      latitude nil
      longitude nil
    end

    trait :invalid do
      no_street_address
      no_coordinates
    end
  end
end
