require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.before(:each, :js) do
    page.driver.browser.url_blacklist = ['https://maps.googleapis.com']
  end
end
