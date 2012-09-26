# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'

class TestDb < Dubot::Db
  def self.dbindex
    15
  end
end

class TestDbNoDbIndex < Dubot::Db ; end

class WordTest < Test::Unit::TestCase
  def test_self_adapter
    assert_equal TestDb, TestDb.adapter
  end

  def test_adapter
    assert_equal TestDb, TestDb.new.adapter
  end

  def test_adapter_call
    assert_equal 'PONG', TestDb.ping
  end

  def test_adapter_call_if_not_defined
    assert_raise NoMethodError do
      TestDbNoDbIndex.ping
    end
 end
end
