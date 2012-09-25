require 'thor'

module Dubot
  class Cli < Thor
    desc "learning", "learning"
    method_option :text, :desc => 'training data (text)'
    method_option :file, :desc => 'training data (file)'
    method_option :user, :desc => 'user for training', :required => true
    def learning
      text = options[:text]
      file = options[:file]
      name = options[:name]

      unless text.nil? or file.nil?
        raise InvocationError, "Can't specify both --text or --file"
      end

      if text.nil? and file.nil?
        raise RequiredArgumentMissingError, "Requires either --text or --file"
      end

      learning = Dubot::Learning.new
      file.nil? ? learning.from_string(name, text) : learning.from_file(name, file)
    end

    desc "sentence", "create sentence"
    method_option :length, :desc => 'Maximum length of generate text', :type => :numeric, :default => 140
    method_option :user,   :desc => 'source user'
    def sentence
      p Dubot::Sentence.new.run(:name => options[:user], :length => options[:length])
    end
  end
end
