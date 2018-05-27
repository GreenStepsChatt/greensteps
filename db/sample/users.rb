FactoryBot.define do
  factory :sample_user, parent: :user do
    confirmed
  end

  factory :sample_admin, parent: :admin do
    confirmed
  end
end

FactoryBot.create_list :sample_user, 3, :with_redeemed_gift_card
FactoryBot.create_list :sample_user, 2, total_points: 3
FactoryBot.create_list :user, 1, :unconfirmed_and_locked_out
FactoryBot.create_list :sample_admin, 3
