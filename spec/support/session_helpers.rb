module SessionHelpers
  attr_reader :current_user

  def create_and_login_user
    stubbed_login_as FactoryGirl.create :user
  end

  def create_and_login_admin
    stubbed_login_as FactoryGirl.create :admin
  end

  def stubbed_login_as(user)
    warden_helpers.login_as(user)
    @current_user = user
    visit after_sign_in_path_for(user)
  end

  def after_sign_in_path_for(resource)
    resource_name = resource_name_for(resource)
    try("#{resource_name.underscore}_root_path") || root_path
  end

  private

  def warden_helpers
    @warden_helpers ||= Class.new.extend(Warden::Test::Helpers)
  end

  def resource_name_for(resource_or_name)
    case resource_or_name.class
    when Symbol, String
      resource_or_name
    else
      resource_or_name.class.name
    end
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
