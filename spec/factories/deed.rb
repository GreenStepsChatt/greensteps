require 'active_support/testing/file_fixtures'

FactoryBot.define do
  # the basic factory only has what's needed for the record to be valid
  factory :deed do
    include ActiveSupport::Testing::FileFixtures

    user
    trash_bags 1

    transient do
      with_before_photo { true }
      with_after_photo { true }
    end

    after(:build) do |deed, evaluator|
      if evaluator.with_before_photo
        deed.before_photo.attach(
          io: File.open(file_fixture('trashed_park.jpeg')),
          filename: 'trashed_park.jpeg',
          content_type: 'image/jpeg'
        )
      end

      if evaluator.with_after_photo
        deed.after_photo.attach(
          io: File.open(file_fixture('clean_park.jpeg')),
          filename: 'trashed_park.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :invalid do
      trash_bags 0
    end

    # this is what we'd expect a deed might look like (although most deeds will
    # probably only have one trash bag)
    factory :sample_deed do
      trash_bags { Faker::Number.between(1, 3) }
    end
  end
end
