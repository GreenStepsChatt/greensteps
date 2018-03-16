require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Greensteps
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    console do
      require 'pry'
      config.console = Pry
    end

    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.view_specs false
      g.jbuilder false
    end

    config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'debug')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
