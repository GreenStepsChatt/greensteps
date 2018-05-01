namespace :rolify do
  desc 'Grants the specified role to the user with the specified email'
  task add_role: [:environment] do |_t, args|
    user = User.find_by(email: args[1])
    user.add_role(args[0])
  end

  desc 'Removes the specified role from the user with the specified email'
  task remove_role: [:environment] do |_t, args|
    user = User.find_by(email: args[1])
    user.remove_role(args[0])
  end
end
