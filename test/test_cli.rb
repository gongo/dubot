# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'

class CliTest < Test::Unit::TestCase
  def test_learning_with_invocation_raise
    assert_equal "Can't specify both --text or --file", capture(:stderr) {
      Dubot::Cli.start [:learning, '--user', 'hoge', '--text', 'a', '--file', 'f']
    }.strip
  end

  def test_learning_with_required_argument_raise
    assert_equal "Requires either --text or --file", capture(:stderr) {
      Dubot::Cli.start [:learning, '--user', 'hoge']
    }.strip
  end
end
