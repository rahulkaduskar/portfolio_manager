ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
   include Rack::Test::Methods
    after(:all) do
      Rails.cache.delete(PortfolioManagement::FILE_FOR_PORTFOLIO)
      Rails.cache.delete(PortfolioManagement::FILE_FOR_SHAREPRICE)
    end
end
