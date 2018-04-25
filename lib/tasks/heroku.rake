namespace :heroku do # rubocop:disable Metrics/BlockLength
  desc 'Tasks to be run just once, after the first deployment'
  task postdeploy: 'db:seed' do
    Rake::Task['db:populate'].invoke if ENV['USE_SAMPLE_DATA']
  end

  desc 'Tasks to be run after each deployment'
  task release: :environment do
    migrate_or_load_schema
    Rake::Task['after_party:run'].invoke
  end

  desc <<~TEXT
    Creates a local Heroku release for local testing of the production
    environment. Run this task with
      heroku local:run rails heroku:local_release -e .env.production \
        DISABLE_DATABASE_ENVIRONMENT_CHECK=1
  TEXT
  task local_release: [
    'db:drop',
    'db:create',
    'db:schema:load',
    'assets:precompile'
  ]

  def migrate_or_load_schema
    if ActiveRecord::Migrator.current_version.zero?
      Rake::Task['db:schema:load'].invoke
    else
      Rake::Task['db:migrate'].invoke
    end
  end
end
