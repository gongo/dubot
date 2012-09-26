# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'
require 'webmock/test_unit'

class YahooDAServiceTest < Test::Unit::TestCase
  def setup
    @http_stub = stub_request(:get, Dubot::YahooDAService::REQUEST_URI)
    @http_stub.with(:query => {:appid => 'APP_ID', :sentence => 'test'})
  end

  def test_request
    response = http_stub_setup(200, DubotTest::FixtureXml.success)

    assert_equal(200, response[:status])
    assert_kind_of(String, response[:body])
  end

  def test_request_failure
    response = http_stub_setup(403, DubotTest::FixtureXml.failure)

    assert_equal(403, response[:status])
    assert_kind_of(String, response[:body])
  end

  private

  def http_stub_setup(status, body)
    @http_stub.to_return(:status => status, :body => body)
    Dubot::YahooDAService.request('APP_ID', 'test')
  end
end
