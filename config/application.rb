require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pfcdbg
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.action_mailer.default_url_options = { host: "http://localhost:3000" }

    config.i18n.default_locale = Settings.locales.default
    config.i18n.available_locales = Settings.locales.available

    #allow multiquery
    config.active_record.async_query_executor = :global_thread_pool
  end
end