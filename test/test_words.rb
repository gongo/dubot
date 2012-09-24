# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'

class WordTest < Test::Unit::TestCase
  def setup
    Dubot::Db.flushall
  end

  def test_save
    name  = 'name'
    text  = 'text'
    head  = 'head'
    chain = 'chain'
    type  = :type

    word = Dubot::Word.save(name, text, head, chain, type)
    assert_equal text,  word.text
    assert_equal chain, word.chain_text
  end
end
