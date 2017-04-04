ENV["RACK_ENV"] ||= "test"
require 'rspec'
require 'capybara/rspec'
require 'capybara/poltergeist'

require_relative '../app.rb'
Dir[__dir__ + '/support/*.rb'].each { |file| require_relative file }

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.before :each do
    OmniAuth.config.mock_auth[:github] = nil
  end
  OmniAuth.config.test_mode = true
  config.include AuthenticationHelper
end
