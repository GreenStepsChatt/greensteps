# users who have signed up, but done nothing yet
FactoryGirl.create_list :user, 30

# a lot of user might sign up, log their first deed, and then forget about the
# project
FactoryGirl.create_list :user, 15, :with_one_deed

# these are the consistent users
FactoryGirl.create_list :user, 5, :with_deeds

# users with admin privelidges
FactoryGirl.create_list :admin, 3
