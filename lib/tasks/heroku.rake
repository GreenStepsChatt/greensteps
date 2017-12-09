namespace :heroku do
  desc 'Tasks to be run just once, after the first deployment'
  task postdeploy: ['db:schema:load', 'db:seed'] do
    Rake::Task['db:populate'].invoke if ENV['USE_SAMPLE_DATA']
  end

  desc 'Tasks to be run after each deployment'
  task release: 'db:migrate'
end
