ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "active_support/testing/setup_and_teardown"

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include Rails.application.routes.url_helpers
  include Capybara::DSL  
  include Rack::Test::Methods
  
  teardown  do
    Rails.cache.delete(PortfolioManagement::FILE_FOR_PORTFOLIO)
    Rails.cache.delete(PortfolioManagement::FILE_FOR_SHAREPRICE)
  end
end
