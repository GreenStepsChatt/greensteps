FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :admin_email do |n|
    "admin#{n}@example.com"
  end

  sequence :developer_email do |n|
    "developer#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password 'password'

    trait :with_deeds do
      after(:create) do |user|
        Faker::Number.between(1, 10).times do
          user.deeds.create(attributes_for(:sample_deed))
        end
      end
    end

    trait :with_one_deed do
      after(:create) { |user| user.deeds.create(attributes_for(:sample_deed)) }
    end

    trait :soft_deleted do
      after(:create, &:destroy)
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

    factory :developer do
      email { generate :developer_email }
      after(:build) { |user| user.add_role :developer }
    end
  end
end
