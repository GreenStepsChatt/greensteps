FactoryBot.define do
  factory :redemption do
    user
    value 1

    trait :invalid do
      value nil
    end

    after(:build) do |redemption, _evaluator|
      next if redemption.valid?
      create :deed, user: redemption.user, trash_bags: redemption.value
    end
  end
end
