require Rails.root.join('lib', 'factory_helpers', 'add_points_to_user.rb')
require Rails.root.join('lib', 'factory_helpers', 'redeem_random_prize.rb')

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :admin_email do |n|
    "admin#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password 'password'

    transient do
      total_points nil
    end

    after(:create) do |user, evaluator|
      AddPointsToUser.new(user, evaluator.total_points)
    end

    trait :with_enough_points_for_a_prize do
      total_points { Faker::Number.between(10, 35) }
    end

    trait :with_redeemed_prize do
      with_enough_points_for_a_prize

      after(:create) do |user|
        RedeemRandomPrize.new(user)
      end
    end

    trait :with_deeds do
      after(:create) do |user|
        create_list :deed, Faker::Number.between(1, 10), user: user
      end
    end

    trait :with_one_deed do
      after(:create) { |user| user.deeds.create(attributes_for(:sample_deed)) }
    end

    trait :soft_deleted do
      deleted_at { Time.zone.now }
    end

    trait :confirmed do
      after(:build, &:skip_confirmation!)
    end

    trait :unconfirmed do
      confirmed_at nil
    end

    trait :unconfirmed_and_locked_out do
      unconfirmed
      created_at { 4.days.ago }
      after(:create) { |user| user.update(confirmation_sent_at: 4.days.ago) }
    end

    factory :admin do
      email { generate :admin_email }
      after(:build) { |user| user.add_role :admin }
    end
  end
end
