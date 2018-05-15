FactoryBot.define do
  factory :redemption do
    user
    association :prize, factory: :prize, cost: 1

    transient do
      invalid false
    end

    trait :invalid do
      invalid true
    end

    after(:build) do |redemption, evaluator|
      next if redemption.valid? || evaluator.invalid
      redemption.user.deeds.create(trash_bags: 1)
    end
  end
end
