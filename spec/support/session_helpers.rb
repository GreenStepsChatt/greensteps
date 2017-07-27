module SessionHelpers
  attr_reader :current_user

  def create_and_login_user
    stubbed_login_as FactoryGirl.create :user
  end

  def stubbed_login_as(user)
    warden_helpers.login_as(user)
    @current_user = user
    visit welcome_index_path
  end

  private
  def warden_helpers
    @warden_helpers ||= Class.new.extend(Warden::Test::Helpers)
  end
end

RSpec.configure do |config|
  # Need to use Warden test helpers instead of Devise. See
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  config.include SessionHelpers, type: :feature
  Warden.test_mode!

  config.after :each do
    Warden.test_reset!
  end
end
