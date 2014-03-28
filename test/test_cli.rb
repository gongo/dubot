# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'

class CliTest < Test::Unit::TestCase
  def test_learning_with_invocation_raise
    assert_raise Thor::InvocationError do
      Dubot::Cli.start [:learning, '--user', 'hoge', '--text', 'a', '--file', 'f']
    end
  end

  def test_learning_with_required_argument_raise
    assert_raise Thor::RequiredArgumentMissingError do
      Dubot::Cli.start [:learning, '--user', 'hoge']
    end
  end
end
