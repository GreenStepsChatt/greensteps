FactoryGirl.define do
  # TODO: implement this via Faker (will need to add a module for this to Faker)
  PRIZE_TITLES ||= [
    "Two free drinks at local pub",
    "$20 gift card to REI",
    "Pack of 3 carabiners",
    "Free appetizer at local pub",
    "$5 gift card to REI"
  ]

  sequence :prize_title do |n|
    PRIZE_TITLES[(n-1) % PRIZE_TITLES.size]
  end

  factory :prize do
    title 'Two free drinks at local pub'
    quantity { Faker::Number.between(1, 30) }
    cost { Faker::Number.between(1,3) * 10 }

    trait :invalid do
      title nil
      quantity 0
      cost nil
    end
  end
end
