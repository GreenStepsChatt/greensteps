# users who have signed up, but done nothing yet
FactoryBot.create_list :user, 30

# a lot of user might sign up, log their first deed, and then forget about the
# project
FactoryBot.create_list :user, 15, :with_one_deed

# these are the consistent users
FactoryBot.create_list :user, 5, :with_deeds

# users with admin privelidges
FactoryBot.create_list :admin, 3
