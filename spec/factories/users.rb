FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :admin_email do |n|
    "admin#{n}@example.com"
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

    factory :admin do
      email { generate :admin_email }
      after(:build) { |user| user.add_role :admin }
    end
  end
end
