ENV['RACK_ENV'] ||= 'development'

begin
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require(:runtime)

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'warden-reliefwatch'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec', 'app'))

run Example.app
