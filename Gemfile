source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'acts_as_paranoid',
    git: 'https://github.com/ActsAsParanoid/acts_as_paranoid.git',
    ref: '085b5cc'
gem 'after_party'
gem 'autoprefixer-rails'
gem 'bitters'
gem 'bourbon'
gem 'coffee-rails', '~> 4.2'
gem 'decent_exposure'
gem 'devise'
gem 'factory_bot_rails'
gem 'faker'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'mail_interceptor'
gem 'pg', '~> 0.18'
gem 'pry'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.1.4'
gem 'record_tag_helper'
gem 'rolify'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.7'
  gem 'rubocop', '~> 0.52', require: false
end

group :development do
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webmock'
end
