require 'thor'

module Dubot
  class Cli < Thor
    desc "learning", "learning"
    option :text, :type => :string, :aliases => '-t', :required => true, :desc => 'learning text'
    option :user, :type => :string, :aliases => '-u', :required => true, :desc => 'user of learning text'
    def learning
      Dubot::Learning.new.from_string(options[:user], options[:text])
    end

    desc "sentence", "create sentence"
    option :user, :type => :array, :aliases => '-u', :desc => 'Source user'
    option :length, :type => :numeric, :default => 140, :aliases => '-l', :desc => 'Maximum length of generate text'
    def sentence
      p Dubot::Sentence.new.run(:name => options[:user], :length => options[:length])
    end
  end
end
