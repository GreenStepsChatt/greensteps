FactoryGirl.define do
  factory :deed do
    user

    trait :invalid do
      miles 0
      trash_bags 0
    end
  end
end
