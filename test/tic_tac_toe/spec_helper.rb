require 'rspec'
require 'capybara'
require 'capybara/rspec'

module RSpecMixin
  include Rack::Test::Methods
  include Capybara::DSL
end

RSpec.configure { |c| c.include RSpecMixin; }
