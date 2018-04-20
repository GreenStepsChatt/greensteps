FactoryBot.define do
  factory :address do
    street '101 Main Street'
    city 'Chattanooga'
    state 'TN'
    zip 10101 # rubocop:disable Style/NumericLiterals

    association :addressable, factory: :station

    trait :invalid do
      street nil
      city nil
      state nil
      zip 0
    end

    trait :with_coordinate_pair do
      coordinate_pair
    end
  end
end
