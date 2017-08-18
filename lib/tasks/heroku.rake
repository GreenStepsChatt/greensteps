namespace :heroku do
  namespace :review_apps do
    desc 'Loads db schema and populates the database with sample data'
    task :postdeploy => ['db:schema:load', 'db:populate']
  end
end
