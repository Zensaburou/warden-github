require 'warden'
require 'oauth2'
require 'json'

module Warden
  module Reliefwatch
    class ReliefwatchMisconfiguredError < StandardError; end
  end
end

require 'addressable/uri'

require 'warden-reliefwatch/user'
require 'warden-reliefwatch/proxy'
require 'warden-reliefwatch/version'
require 'warden-reliefwatch/strategy'
