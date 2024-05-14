require 'rspec'
require 'httparty'
require 'json'
require 'pass2u'
require 'bundler/setup'

require_relative '../lib/pass2u/client'

Bundler.setup

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end