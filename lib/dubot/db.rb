# -*- coding: utf-8 -*-
require 'redis'
require 'singleton'

module Dubot
  class Db
    include Singleton

    def initialize
      @redis = connection_start
    end

    def self.connection
      instance.redis
    end

    def redis
      @redis
    end

    private

    def connection_start
      uri = URI.parse(Config.redis)
      Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    end
  end
end

