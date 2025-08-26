# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'pundit/matchers'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

# Load support files
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  # Host por defecto para los request specs
  config.before(:each, type: :request) do
    # Esto hace que `url_for`, Devise, ActionMailer y demás usen este host
    Rails.application.routes.default_url_options[:host] = 'www.example.com'
  end
  # FactoryBot shortcuts: `create`, `build`, etc.
  config.include FactoryBot::Syntax::Methods

  # Devise helpers for controller specs
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.include RequestAuthHelper, type: :request

  config.include ActiveSupport::Testing::TimeHelpers

  # If you ever need Warden helpers, you can re-enable these:
  # config.include Warden::Test::Helpers, type: :request
  # config.before(:suite) { Warden.test_mode! }
  # config.after(:each, type: :request) { Warden.test_reset! }

  # Use transactional fixtures
  config.use_transactional_fixtures = true

  # Automatically infer spec types from file location
  config.infer_spec_type_from_file_location!

  # Filter Rails backtrace
  config.filter_rails_from_backtrace!
end
