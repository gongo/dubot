require 'dubot/version'
require 'dubot/cli'
require 'dubot/config'
require 'dubot/db'
require 'dubot/model'
require 'dubot/models/words'

module Dubot
  autoload :AnalysisResults,      'dubot/models/analysis_results'
  autoload :Lerning,              'dubot/lerning'
  autoload :YahooDAService,       'dubot/yahoo_daservice'
  autoload :JaDependencyAnalyzer, 'dubot/ja_dependency_analyzer'
  autoload :Type,                 'dubot/type'
  autoload :Learning,             'dubot/learning'
  autoload :Sentence,             'dubot/sentence'
end
