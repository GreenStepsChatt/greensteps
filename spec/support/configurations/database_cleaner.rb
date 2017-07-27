require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
    Rails.application.load_seed
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    # use the `:except` option to exclude seeded tables since we only seed the
    # test database once, in a `before :suite` hook
    DatabaseCleaner.strategy = :deletion # faster when there's not many rows
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, js: true) do
    Rails.application.load_seed
  end
end
