require "dubot/version"

module Dubot
  require 'dubot/cli'
  require 'dubot/db'
  require 'dubot/config'
  require 'dubot/models/words'

  autoload :AnalysisResults,      'dubot/models/analysis_results'
  autoload :Lerning,              'dubot/lerning'
  autoload :YahooDAService,       'dubot/yahoo_daservice'
  autoload :JaDependencyAnalyzer, 'dubot/ja_dependency_analyzer'
  autoload :Type,                 'dubot/type'
  autoload :Learning,             'dubot/learning'
  autoload :Sentence,             'dubot/sentence'
end
