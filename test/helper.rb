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
    def connection_start
      MockRedis.new
    end
  end
end


# thor/spec/spec_helper.rb
require 'stringio'
def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end
