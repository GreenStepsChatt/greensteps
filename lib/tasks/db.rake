require Rails.root.join('lib', 'swapper')

namespace :db do
  desc 'Populates the database with sample data (defined in db/sample)'
  task populate: :environment do
    Swapper.while(ActionMailer::Base).has(:perform_deliveries).set_to(false) do
      Dir[Rails.root.join('db', 'sample', '**', '*.rb')].each { |f| require f }
    end
  end

  desc 'Resets the database and then populates it with the sample data'
  task repopulate: %i[reset populate]
end
