FactoryBot.define do
  factory :sample_user, parent: :user do
    confirmed
  end

  factory :sample_admin, parent: :admin do
    confirmed
  end
end

# users who have signed up, and confirmed their email, but haven't logged
# anything
FactoryBot.create_list :sample_user, 5

# users who have signed up, but done nothing yet
FactoryBot.create_list :user, 25, :unconfirmed_and_locked_out

# a lot of user might sign up, log their first deed, and then forget about the
# app
FactoryBot.create_list :sample_user, 15, :with_one_deed

# these are the consistent users
FactoryBot.create_list :sample_user, 5, :with_deeds

# users with admin privelidges
FactoryBot.create_list :sample_admin, 3
