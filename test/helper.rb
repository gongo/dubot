# -*- coding: utf-8 -*-
ENV["THOR_DEBUG"] = '1'

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
    def connection_start
      MockRedis.new
    end
  end
end
