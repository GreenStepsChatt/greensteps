FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email { generate(:email) }
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
  end
end
