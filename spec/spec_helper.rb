# require "bundler/setup"
# require "user_time_zones"
#
# RSpec.configure do |config|
#   # Enable flags like --only-failures and --next-failure
#   config.example_status_persistence_file_path = ".rspec_status"
#
#   config.expect_with :rspec do |c|
#     c.syntax = :expect
#   end
# end

$LOAD_PATH.unshift(File.dirname(__FILE__))
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'rspec/rails'
# require 'shoulda-matchers'
require 'capybara/rails'
require 'capybara/rspec'
# require 'database_cleaner'
require 'factory_girl'
# require 'timecop'
# require 'support/mailer'

Rails.backtrace_cleaner.remove_silencers!

# Load factory girl factories.
Dir[File.join(File.dirname(__FILE__), 'factories/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema! # rails 4.1+

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.order = :random
  config.use_transactional_fixtures = true

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
  end

  config.after(:each, type: :feature) do
    # DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end

