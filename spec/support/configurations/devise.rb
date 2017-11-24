RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.before(:each, :devise, type: :controller) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
end
