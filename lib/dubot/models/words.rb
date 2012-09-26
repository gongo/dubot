# -*- coding: utf-8 -*-
require 'json'

module Dubot
  class Word < Dubot::Db
    #
    #
    #
    PREFIX = 'uid'

    attr :text, :chain_text

    def initialize(uid, text, chain_text)
      @uid  = uid
      @text = text
      @chain_text = chain_text
    end

    #
    # Dubot::Word の データベースインデックス
    #
    # @return [Integer] 0
    #
    def self.dbindex
      0
    end

    #
    # 繋がる単語を取得する
    #
    # @param [String]
    #   user ユーザ名。もし指定されていれば、そのユーザの発言から検索する
    #
    # @return [Word]
    #   存在しなければ nil
    #
    def cont(user = nil)
      self.class.cont(user, @chain_text)
    end

    #
    # 自身から連結する単語を呼び続ける
    #
    # @example word から繋がるテキストを連結していき、140 文字を越えたら抜ける
    #   word   = Word.start
    #   output = ''
    #   word.chain { |text|
    #     output += text
    #     break if output.length > 140
    #   }
    #
    # @yield [text]
    # @yieldparam [String] 連結した単語の文字列
    #
    def chain(user = nil)
      cur_word = self
      while (next_word = cur_word.cont(user)) do
        yield next_word.text
        cur_word = next_word
      end
    end

    class << self

      #
      # 指定した id の Word を返す
      #
      # @see http://redis.io/commands/get
      #
      # @param [String]
      #   uid 単語のID
      #
      # @return [Word]
      #  存在しなければ nil
      #
      def find(uid)
        ret = nil

        if uid.instance_of?(String) && /^#{PREFIX}\d+$/ === uid
          text, chain_text = JSON.parse(adapter.get(uid))
          ret = self.new(uid, text, chain_text)
        end

        ret
      end

      #
      # 文頭になりえる Word を返す
      #
      # @param [String]
      #   user ユーザ名。もし指定されていれば、そのユーザの発言から検索する
      #
      # @return [Dubot::Word]
      #   存在しなければ nil
      #
      def start(user = nil)
        random_inter 'type:head', get_user_key(user)
      end

      #
      # 繋がる単語を取得する
      #
      # @param [String]
      #   user ユーザ名。もし指定されていれば、そのユーザの発言から検索する
      #
      # @param [String]
      #   chain_text 繋げる単語
      #
      # @return [Word]
      #   存在しなければ nil
      #
      def cont(user = nil, chain_text = nil)
        random_inter get_head_key(chain_text), get_user_key(user)
      end

      #
      # 全件からランダムで取得する
      #
      # @return [Word]
      #
      def random
        find(adapter.srandmember('words'))
      end

      #
      # @see http://redis.io/commands/sinter
      #
      # @example key = 'type:head' の中からランダムで取得
      #   random_inter 'type:head'
      #
      # @example 両方にあるデータからランダムで取得
      #   random_inter 'type:head', 'user:hoge'
      #
      def random_inter(*args)
        adapter.sinterstore('candidate', *args)
        find(adapter.srandmember('candidate'))
      end

      #
      # @see http://redis.io/commands/sunion
      #
      # @example key = 'type:head' の中からランダムで取得
      #   random_union 'type:head'
      #
      # @example どちらかにあるデータからランダムで取得
      #   random_union 'type:head', 'user:hoge'
      #
      def random_union(*args)
        adapter.sunionstore('candidate', *args)
        find(adapter.srandmember('candidate'))
      end

      #
      # @param [String]
      #   user ユーザ名
      #
      # @param [String]
      #   text 本文
      #
      # @param [String]
      #   head text の文頭
      #
      # @param [String]
      #   chain text の文末
      #
      # @param [Symbol]
      #   type [:head, :cont, :stop, :last]
      #
      # @return [Word]
      #   保存した Word
      #
      def save(user, text, head, chain, type)
        id = PREFIX + get_msg_id
        adapter.set id, [text, chain].to_json
        adapter.sadd "words", id
        adapter.sadd "user:#{user}", id
        adapter.sadd "type:#{type}", id
        adapter.sadd "head:#{head}", id
        find(id)
      end

      private

      #
      # @param [Array, String]
      #   user 検索対象とするユーザ(複数, 単数)
      #
      # @return [String]
      #   user が Array の場合、SUNIONSTORE の dstkey
      #   user が String の場合、"user:#{user}"
      #   それ以外の場合は ''
      #
      def get_user_key(user)
        case
        when user.instance_of?(Array)
          adapter.sunionstore(__method__.to_s, user.map { |u| "user:#{u}" })
          __method__.to_s
        when user.instance_of?(String)
          "user:#{user}"
        else
          []
        end
      end

      #
      # @param [String]
      #   head 検索対象とする head
      #
      # @return [String]
      #   head が String の場合は "head:#{user}"
      #
      # @return [Array]
      #   head が String 以外の場合は []
      #
      def get_head_key(head)
        head.instance_of?(String) ? "head:#{head}" : []
      end

      def get_msg_id
        adapter.incr("msg_id").to_s
      end
    end
  end
end
