# frozen_string_literal: true

dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda Sequel::Model], logger: logger, reload: dev) { Ads }
require_relative 'models'
Unreloader.require('app.rb') { 'Ads' }
run(dev ? Unreloader : Ads.freeze.app)
