require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wei
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/app/models/[a-z]*s/"]
    config.autoload_paths += %W(#{config.root}/lib/)

    config.paths['config/routes.rb'].concat(Dir[config.root.join('config/routes/*.rb'), "#{config.root}/lib/**/*.rb"])
    config.time_zone = 'Beijing'
    config.i18n.available_locales = ['zh-CN', :en]
    config.i18n.default_locale = 'zh-CN'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
