require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, debug: true)
end

Capybara.asset_host = 'http://localhost:3000/public'
Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.prune_strategy = :keep_last_run

RSpec.configure do |config|
  config.before(:each, :js) do
    page.driver.browser.url_blacklist = ['https://maps.googleapis.com']
  end
end
