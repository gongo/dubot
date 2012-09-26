# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'

class TestModel < Dubot::Model
  DB_INDEX = 15
end

class TestModelNoDbIndex < Dubot::Model ; end

class ModelTest < Test::Unit::TestCase
  def test_self_adapter
    assert_equal Dubot::Db.connection, TestModel.adapter
  end

  def test_adapter
    assert_equal Dubot::Db.connection, TestModel.new.adapter
  end

  def test_adapter_call
    assert_equal 'PONG', TestModel.adapter.ping
  end

  def test_adapter_call_if_not_defined
    assert_raise NameError do
      TestModelNoDbIndex.adapter.ping
    end
 end
end
