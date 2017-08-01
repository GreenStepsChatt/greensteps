namespace :db do
  desc 'Populates the database with sample data (defined in db/sample)'
  task populate: :environment do
    Dir[Rails.root.join('db', 'sample', '**', '*.rb')].each { |f| require f }
  end

  desc 'Resets the database and then populates it with the sample data'
  task repopulate: %i[reset populate]
end
