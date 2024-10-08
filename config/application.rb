require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Twitter
  class Application < Rails::Application

    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))
    
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    
  end
end
