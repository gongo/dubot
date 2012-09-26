require 'redis'

module Dubot
  class Db
    @redis = nil

    def self.method_missing(id, *args)
      redis.send(id, *args)
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

