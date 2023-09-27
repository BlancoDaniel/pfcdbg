require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pfcdbg
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0


    config.i18n.default_locale = Settings.locales.default
    config.i18n.available_locales = Settings.locales.available

  end
end