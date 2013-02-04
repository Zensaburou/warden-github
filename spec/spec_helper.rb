require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
  add_filter '/example'
end

require 'warden/github'
require File.expand_path('../../example/app', __FILE__)
require 'rack/test'
require 'webrat'
require 'addressable/uri'
require 'pp'
require 'webmock/rspec'

Webrat.configure do |config|
  config.mode = :rack
  config.application_port = 4567
end

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)

  config.before(:each) do
  end

  def app
    Example.app
  end
end
