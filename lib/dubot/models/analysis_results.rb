# -*- coding: utf-8 -*-
require 'json'

module Dubot
  class AnalysisResults < Dubot::Db
    include Enumerable

    KEY = "analysis_results"

    #
    # Dubot::AnalysisResults の データベースインデックス
    #
    # @return [Integer] 1
    #
    def self.dbindex
      1
    end

    #
    # Yahoo Developer API の形態素・係り受け解析結果 を
    # ユーザと紐付けて保存する
    #
    # @see http://redis.shibu.jp/commandreference/lists.html#command-LPUSH
    #
    # @param [String]
    #   user ユーザ名
    #
    # @param [Array]
    #   body Yahoo Developer API の形態素・係り受け解析結果 パース
    #
    # @return [Integer]
    #   現在保存されている解析結果の数
    #
    def self.insert(user, body)
      adapter.rpush KEY, {'user' => user, 'body' => body}.to_json
    end

    def self.each
      return to_enum(:each) unless block_given?
      all.each do |record|
        obj = JSON.parse(record)
        yield obj['user'], obj['body']
      end
    end

    #
    # 保存されている Yahoo Developer API の形態素・係り受け解析結果の全てを返す
    #
    # @see http://redis.shibu.jp/commandreference/lists.html#command-LRANGE
    #
    # @return [Array]
    #   現在保存されている解析結果の配列
    #   各要素は "user:xml"
    #
    def self.all
      adapter.lrange KEY, 0, -1
    end
  end
end
