# frozen_string_literal: true

require_relative 'models'

require 'roda'
require 'tilt/sass'

class Ads < Roda
  plugin :hash_routes

  plugin :json,
         classes: [Array, Hash, Sequel],
         serializer: proc { |object|
           case object
           when Array, Hash
             object.to_json
           else
             Serializer.new(object).as_json
           end
         }

  logger = if ENV['RACK_ENV'] == 'test'
             Class.new { def write(_) end }.new
           else
             $stderr
           end
  plugin :common_logger, logger

  Unreloader.require('routes') {}

  hash_routes do
    view '', 'index'
  end

  require 'jsonapi/serializer'
  Dir['serializers/*.rb'].each { |f| require_relative f }

  route do |r|
    r.hash_routes('')
  end
end
