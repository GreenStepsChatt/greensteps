namespace :heroku do
  desc 'Tasks to be run just once, after the first deployment'
  task postdeploy: 'db:seed' do
    Rake::Task['db:populate'].invoke if ENV['USE_SAMPLE_DATA']
  end

  desc 'Tasks to be run after each deployment'
  task release: :environment do
    migrate_or_load_schema
    Rake::Task['after_party:run'].invoke
  end

  def migrate_or_load_schema
    if ActiveRecord::Migrator.current_version.zero?
      Rake::Task['db:schema:load'].invoke
    else
      Rake::Task['db:migrate'].invoke
    end
  end
end
