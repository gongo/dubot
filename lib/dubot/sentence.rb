# -*- coding: utf-8 -*-

module Dubot
  class Sentence
    DEFAULT_OPTIONS = { :name => nil, :length => 140 }

    #
    # @example 最大140文字の文章を生成
    #   sentence = Dubot::Sentence.new
    #   sentence.run
    #
    # @example 最大200文字で、gongo 及び dubot に紐付く単語から文章を生成
    #   sentence.run(:name => ['gongo', 'dubot'], :length => 200)
    #
    # @param [Hash] options
    #
    # @option options [Array]
    #   :name 生成する文章の発言元ユーザ
    #
    # @option options [Integer]
    #   :length 生成する文章の最大文字数
    #
    def run(options = {})
      opt = self.class::DEFAULT_OPTIONS.merge(options)
      name = opt[:name]
      length = opt[:length]

      word = Dubot::Word.start(name)
      return "" if word.nil?

      output = word.text
      word.chain(name) { |text|
        output += text
        break if output.length > length
      }

      output
    end
  end
end
