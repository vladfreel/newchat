require_relative 'boot'
require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Newchat
  # Application
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.active_record.observers = :user_observer
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Kyiv'
    config.i18n.available_locales = [:ru, :en]
    config.i18n.default_locale = :ru
    config.assets.initialize_on_precompile = false
    config.assets.precompile += %w[active_admin.css active_admin.js print.css]
    config.assets.precompile += %w[active_admin/print.css]
  end
end
