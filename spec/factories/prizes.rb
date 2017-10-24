FactoryGirl.define do
  factory :prize do
    title 'Two free drinks at local pub'
    quantity 1
    cost 1

    trait :invalid do
      title nil
      quantity 0
      cost nil
    end
  end
end
