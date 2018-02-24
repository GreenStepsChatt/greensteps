FactoryBot.define do
  factory :address do
    street '101 Main Street'
    city 'Chattanooga'
    state 'Tennesse'
    zip 10101 # rubocop:disable Style/NumericLiterals

    association :addressable, factory: :station
  end
end
