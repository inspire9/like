require 'bundler'

Bundler.setup :default, :development

require 'combustion'
require 'like'
require 'devise'

Combustion.initialize! :action_controller, :active_record

require 'rspec/rails'
require 'capybara/rails'

Dir["./spec/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.include RSpec::Rails::RequestExampleGroup, type: :request,
    example_group: {file_path: /spec\/acceptance/}
  config.include Capybara::DSL, type: :request,
    example_group: {file_path: /spec\/acceptance/}
end
