ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'mocha/setup'
require 'minitest/mock'
require 'sidekiq/testing'

require 'minitest/reporters'

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new({ color: true })]


Sidekiq::Testing.inline!

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def setup
    super
  end

end

require 'pp'
