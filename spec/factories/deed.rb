FactoryGirl.define do
  # the basic factory only has what's needed for the record to be valid
  factory :deed do
    user

    trait :invalid do
      miles 0
      trash_bags 0
    end

    # this is what we'd expect a deed might look like (although most deeds will
    # probably only have one trash bag)
    factory :sample_deed do
      miles { Faker::Number.between(1, 5) }
      trash_bags { Faker::Number.between(1, 3) }
    end
  end
end
