# -*- coding: utf-8 -*-
require 'redis'

module Dubot
  class Db
    @redis = nil

    def self.method_missing(id, *args)
      raise NoMethodError, "#{self.name}.#{id} is not defined" if id == :dbindex
      redis.select dbindex
      redis.send(id, *args)
    end

    #
    # 自身のデータを全て削除する
    #
    # @see http://redis.io/commands/flushdb
    #
    def self.delete_db
      redis.flushdb
    end

    #
    # 全てのデータベースのデータを全て削除する
    #
    # @see http://redis.io/commands/flushall
    #
    def self.delete_db_all
      redis.send(:flushall)
    end

    def self.adapter
      self
    end

    def adapter
      self.class
    end

    private

    def self.redis
      unless @redis
        uri = URI.parse(Config.redis)
        @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      end
      @redis
    end
  end
end

