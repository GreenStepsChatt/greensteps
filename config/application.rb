require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Greensteps
  class Application < Rails::Application
    console do
  require 'pry'
  config.console = Pry
end

    config.i18n.load_path +=
  Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.view_specs false
  g.jbuilder false
end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
