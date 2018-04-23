require Rails.root.join('lib', 'swapper')

namespace :db do
  desc 'Populates the database with sample data (defined in db/sample)'
  task populate: :environment do
    Swapper.while(ActionMailer::Base).has(:perform_deliveries).set_to(false) do
      Swapper.while(Delayed::Worker).has(:delay_jobs).set_to(false) do
        sample_data_files = Rails.root.join('db', 'sample', '**', '*.rb')
        Dir[sample_data_files].each { |f| require f }
      end
    end
  end

  desc 'Resets the database and then populates it with the sample data'
  task repopulate: %i[reset populate]
end
