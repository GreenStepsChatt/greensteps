FactoryBot.define do
  factory :redemption do
    user
    association :prize, factory: :prize, cost: 1

    transient do
      force_invalid false
    end

    trait :invalid do
      force_invalid true
    end

    after(:build) do |redemption, evaluator|
      next if redemption.valid? || evaluator.force_invalid
      create :deed, user: redemption.user, trash_bags: 1
    end
  end
end
