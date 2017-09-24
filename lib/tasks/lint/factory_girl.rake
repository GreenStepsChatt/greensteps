namespace :lint do
  desc 'Verify that all Factory Girl factories are valid'
  task factory_girl: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.start
        FactoryGirl.lint
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bundle exec rake lint:factory_girl RAILS_ENV='test'")
    end
  end
end
