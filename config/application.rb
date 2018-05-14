require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ServerYzd
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.default_timezone = :local

    config.time_zone = 'Beijing'

    # redis cache
    config.cache_store = :redis_store, {:url => 'redis://127.0.0.1:6379/0/cache'}, {expires_in: 12.hours }
  end
  require 'publify_login_system'
end
