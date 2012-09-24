# -*- coding: utf-8 -*-
require 'helper'
require 'fixture_xml'

class JaDependencyAnalyzerTest < Test::Unit::TestCase
  def test_from_xml
    expect_surfaces = [
                       %w{私 の},
                       %w{名前 は},
                       %w{ご ん ご です}
                      ]
    expect_features = [
                       %w{名詞名詞人 助詞助詞連体化},
                       %w{名詞名詞 助詞係助詞},
                       %w{接頭辞接頭ご 感動詞感動 接頭辞接頭ご 助動詞助動詞です}
                      ]

    result = Dubot::JaDependencyAnalyzer.from_xml(DubotTest::FixtureXml.success)

    assert_equal(expect_surfaces.count, result.count)
    assert_equal(expect_surfaces, result.map {|f| f.surfaces })
    assert_equal(expect_features, result.map {|f| f.features })
  end

  def test_from_xml_failure
    result = Dubot::JaDependencyAnalyzer.from_xml(DubotTest::FixtureXml.failure)
    assert_equal('error message', result)
  end

  def test_from_xml_noXML
    result = Dubot::JaDependencyAnalyzer.from_xml(DubotTest::FixtureXml.no_xml)
    assert_equal([], result)
  end

  def test_from_xml_noYahooXML
    result = Dubot::JaDependencyAnalyzer.from_xml(DubotTest::FixtureXml.no_yahoo_xml)
    assert_equal([], result)
  end

  def test_from_xml_nil
    result = Dubot::JaDependencyAnalyzer.from_xml(nil)
    assert_equal([], result)
  end
end
