FactoryBot.define do
  factory :redemption do
    user

    trait :with_cost_5 do
      cost 5
    end

    trait :with_cost_10 do
      cost 10
    end
  end
end
