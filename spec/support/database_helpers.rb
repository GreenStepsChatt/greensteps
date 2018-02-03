require 'database_cleaner'

module DatabaseHelpers
  def reset_db_with_database_cleaner
    DatabaseCleaner.clean_with(:deletion)
    Rails.application.load_seed
  end
end

RSpec.configure do |config|
  include DatabaseHelpers

  config.before(:suite) do
    reset_db_with_database_cleaner
  end

  config.include DatabaseHelpers
  config.extend DatabaseHelpers
end
