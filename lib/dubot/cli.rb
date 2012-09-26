require 'thor'

module Dubot
  class Cli < Thor
    desc "learning", "learning"
    method_option :text, :desc => 'training data (text)'
    method_option :file, :desc => 'training data (file)'
    method_option :user, :desc => 'name for training user', :required => true
    def learning
      text = options[:text]
      file = options[:file]
      user = options[:user]

      unless text.nil? or file.nil?
        raise InvocationError, "Can't specify both --text or --file"
      end

      if text.nil? and file.nil?
        raise RequiredArgumentMissingError, "Requires either --text or --file"
      end

      learning = Dubot::Learning.new
      file.nil? ? learning.from_string(user, text) : learning.from_file(user, file)
    end

    desc "sentence", "create sentence"
    method_option :length, :desc => 'Maximum length of generate text', :type => :numeric, :default => 140
    method_option :user,   :desc => 'source users', :type => :array
    def sentence
      p Dubot::Sentence.new.run(:user => options[:user], :length => options[:length])
    end

    desc "relearning", "relearning from analysis results"
    def relearning
      Dubot::Learning.new.rebuild
    end
  end
end
