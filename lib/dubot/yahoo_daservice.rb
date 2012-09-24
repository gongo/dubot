require 'erb'
require 'ostruct'
require 'open-uri'

module Dubot
  class YahooDAService
    REQUEST_URI = 'http://jlp.yahooapis.jp/DAService/V1/parse'

    def self.request(app_id, text)
      query = "appid=#{url_encode(app_id)}&sentence=#{url_encode(text.chomp)}"

      begin
        response = open("#{REQUEST_URI}?#{query}")
      rescue OpenURI::HTTPError => e
        response = e.io
      ensure
        analysis = OpenStruct.new({
          :status => response.status[0].to_i,
          :body   => response.read
        })
        response.close
      end

      analysis
    end

    private

    def self.url_encode text
      ERB::Util.url_encode text
    end
  end
end
