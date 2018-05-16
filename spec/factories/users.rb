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
      total_points = evaluator.total_points
      next if total_points.blank?
      deeds_count = Faker::Number.between(1, total_points)

      (deeds_count - 1).downto(1).reduce(total_points) do |remaining_points, deeds_left|
        points_available_for_this = remaining_points - deeds_left
        break if points_available_for_this == 0
        points_for_this_deed = Faker::Number.between(1, points_available_for_this)
        create :sample_deed, user: user, trash_bags: points_for_this_deed

        remaining_points - points_for_this_deed
      end
      if (deeds_count - user.deeds.count) > 1
        create_list :sample_deed, (deeds_count - user.deeds.count - 1), user: user, trash_bags: 1
      else
        create :sample_deed, user: user, trash_bags: (total_points - user.total_points)
      end
    end

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
