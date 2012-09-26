# -*- coding: utf-8 -*-
require 'yaml'
require 'singleton'

module Dubot
  class Config
    include Singleton

    class << self
      def method_missing(id)
        config = instance.config
        config.key?(id.to_s) ? config[id.to_s] : super(id)
      end
    end

    def initialize
      @config = YAML.load_file(config_path)
    end

    def config
      @config
    end

    private

    def config_path
      "#{File.expand_path('../../../config', __FILE__)}/config.yml"
    end
  end
end
