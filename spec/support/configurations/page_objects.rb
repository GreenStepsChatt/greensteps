require_relative '../../page_objects/base'
Dir["#{__dir__}/../../page_objects/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include PageObjects, type: :feature
end
