# -*- coding: utf-8 -*-
require 'ostruct'
require 'yaml'

module Dubot
  class Config < OpenStruct
    def self.instance
      unless @instance
        @instance = self.load
      end
      @instance
    end

    def self.load
      self.new
    end

    def initialize
      super YAML.load_file config_path
    end

    private

    def config_path
      "#{File.expand_path('../../../config', __FILE__)}/config.yml"
    end
  end
end

