require 'rspec'
require 'json'
require 'pass2u'
require 'bundler/setup'

require_relative '../lib/pass2u/client'

Bundler.setup

RSpec.configure do |config|
  config.expect_with :rspec do |conf|
    conf.syntax = :expect
  end
end