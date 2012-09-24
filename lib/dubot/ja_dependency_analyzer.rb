# -*- coding: utf-8 -*-
require 'rexml/document'
require 'ostruct'

module Dubot
  class JaDependencyAnalyzer
    def self.from_text(text)
      app_id = Config.instance.yahoo_api
      response = YahooDAService.request(app_id, text)
      from_xml(response.body)
    end

    #
    # Yahoo Developer API の形態素・係り受け解析結果を parse して返す
    #
    # @see http://developer.yahoo.co.jp/webapi/jlp/da/v1/parse.html
    # @see http://developer.yahoo.co.jp/appendix/errors.html
    #
    # @param [String]
    #   xml Yahoo Developer API の 形態素・係り受け解析結果 (XML)
    #
    # @return [Array]
    #   parse したオブジェクトの配列
    #     obj.id         => 文節の番号
    #     obj.surfaces   => 文節内にある形態素の表記の配列
    #     obj.features   => 文節内にある形態素の品詞+品詞詳細の配列
    #     obj.dependency => この文節の係り受け先
    #
    # @return [String]
    #   形態素・係り受け解析に失敗した理由が記述された文字列
    #
    def self.from_xml(xml)
      doc = REXML::Document.new(xml)

      if !doc.elements['/Error/Message'].nil?
        return doc.elements['/Error/Message'].get_text.to_s.gsub("\n", "")
      end

      chunk_list = []

      doc.each_element('ResultSet/Result/ChunkList/Chunk') do |chunk|
        surfaces = chunk.get_elements('MorphemList/Morphem/Surface').map { |s|
          s.text
        }
        features = chunk.get_elements('MorphemList/Morphem/Feature').map { |f|
          f.text.split(',').shift(2).join
        }

        chunk_list << OpenStruct.new({
          :id         => chunk.get_text('Id').to_s.to_i,
          :surfaces   => surfaces,
          :features   => features,
          :dependency => chunk.get_text('Dependency').to_s.to_i
        })
      end

      chunk_list
    end
  end
end
