FactoryBot.define do
  factory :sample_user, parent: :user do
    confirmed
  end

  factory :sample_admin, parent: :admin do
    confirmed
  end
end

FactoryBot.create_list :sample_user, 3, :with_redeemed_prize
FactoryBot.create_list :sample_user, 2, :with_enough_points_for_a_prize
FactoryBot.create_list :user, 25, :unconfirmed_and_locked_out
FactoryBot.create_list :sample_user, 15
FactoryBot.create_list :sample_user, 5
FactoryBot.create_list :sample_admin, 3
