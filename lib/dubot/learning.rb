# -*- coding: utf-8 -*-

module Dubot
  class Learning
    #
    # surfaces の連結数
    #
    CHAIN_NUM = 2

    #
    # 文頭と判断する品詞+品詞詳細の配列
    #
    START_FEATURES = %w{名詞 副詞副詞 形容詞形容 動詞(ラ五|一段|ワ五) (感動|接続|連体)詞 接尾辞助数}

    #
    # 文末と判断する品詞+品詞詳細の配列
    #
    END_FEATURES =  %w{特殊(単漢|句点) (名|動)詞 助詞終助詞 助動詞助動詞 副詞副詞 接尾辞助数}

    def initialize
    end

    def from_string(user, text)
      result = JaDependencyAnalyzer.from_text(text)

      if (result.instance_of?(Array) && !result.empty?)
        AnalysisResults.insert(user, result)
        save_words(user, result)
      end
    end

    def from_file(user, file)
      File.open(file).each_line do |line|
        from_string(user, line)
      end
    end

    def rebuild
      Word.adapter.flushdb
      AnalysisResults.each do |user, result|
        save_words(user, result)
      end
    end

    private

    def save_words(user, chunk_list)
      make_dependency(chunk_list).each do |word|
        Word.save(user, word[:text], word[:head], word[:next], word[:type])
      end
    end

    def make_dependency(chunk_list)
      words = [{ :head => "", :next => "", :text => "", :type => :stop }]

      chunk_list.each do |chunk|
        surfaces = chunk['surfaces']
        features = chunk['features']

        text = surfaces.join
        head = surfaces[0...CHAIN_NUM].join
        type = get_type(features, chunk['id'], chunk['dependency'])

        unless [:stop, :last].include?(words.last[:type])
          words.last[:next] = head
        end

        words << { :head => head, :next => "", :text => text, :type => type }
      end

      words.shift
      words
    end

    def get_type(features, id, dependency)
      if dependency == -1
        type = end_feature?(features.last) ? :stop : :last
      elsif id == 0 and start_feature?(features.first)
        type = :head
      else
        type = :cont
      end
      type
    end

    def start_feature?(feature)
      /^(#{START_FEATURES.join('|')})/ === feature
    end

    def end_feature?(feature)
      /^(#{END_FEATURES.join('|')})/ === feature
    end
  end
end
