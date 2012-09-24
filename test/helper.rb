# -*- coding: utf-8 -*-
require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
  add_filter "/vendor/"
end

require 'test/unit'
require 'dubot'

require 'mock_redis'

module Dubot
  class Db
    private

    def self.redis
      unless @redis
        @redis = MockRedis.new
      end
      @redis
    end
  end
end
