ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
["spec/support/**/*.rb", "spec/factories/**/*.rb"].each do |path|
  Dir[Rails.root.join(path)].each { |f| require f }
end

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.order = "random"
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.global_fixtures = :all

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    Capybara.default_host = "http://example.com"
    DatabaseCleaner.start
  end

  config.before(:each, twilio: true) do
    Twilio::REST::Client.stub_chain(:new, :account, :calls, :create)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def log_in(authentication)
  Capybara.current_session.driver.browser.clear_cookies

  authentication = authentication.authentication if authentication.is_a? User

  controller.session[:authentication_id] = authentication.id
end
