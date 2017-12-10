namespace :heroku do
  desc 'Tasks to be run just once, after the first deployment'
  task postdeploy: 'db:seed' do
    Rake::Task['db:populate'].invoke if ENV['USE_SAMPLE_DATA']
  end

  desc 'Tasks to be run after each deployment'
  task :release do
    if ActiveRecord::Migrator.current_version == 0
      Rake::Task['db:schema:load'].invoke
    else
      Rake::Task['db:migrate'].invoke
    end
  end
end
