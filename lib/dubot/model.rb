module Dubot
  class Model
    def self.adapter
      conn = Dubot::Db.connection
      conn.select self::DB_INDEX
      conn
    end

    def self.truncate
      adapter.flushdb
    end

    def adapter
      self.class.adapter
    end
  end
end
