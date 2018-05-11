FactoryBot.define do
  # the basic factory only has what's needed for the record to be valid
  factory :deed do
    user

    trait :invalid do
      trash_bags 0
    end

    trait :with_before_photo do
      after(:build) do |deed|
        deed.before_photo.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'trashed_park.jpeg')),
          filename: 'trashed_park.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_after_photo do
      after(:build) do |deed|
        deed.after_photo.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'clean_park.jpeg')),
          filename: 'trashed_park.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_photos do
      with_before_photo
      with_after_photo
    end

    # this is what we'd expect a deed might look like (although most deeds will
    # probably only have one trash bag)
    factory :sample_deed do
      trash_bags { Faker::Number.between(1, 3) }
    end
  end
end
