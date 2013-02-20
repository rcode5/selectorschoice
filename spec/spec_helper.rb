ENV["RAILS_ENV"] ||= 'test'

require File.expand_path('../../config/boot', __FILE__)
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/{factories,support}/**/*.rb")].each {|f| require f}

#Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  
  config.mock_with :rspec
  
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

end
