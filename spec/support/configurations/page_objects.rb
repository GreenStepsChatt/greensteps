require_relative '../../page_objects/page_objects'

RSpec.configure do |config|
  config.include PageObjects, type: :feature
end
