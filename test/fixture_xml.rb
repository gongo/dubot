# -*- coding: utf-8 -*-

module DubotTest
  class FixtureXml

    #
    # 「私の名前はごんごです」の解析結果 XML
    #
    def self.success
      <<-EOS
<?xml version="1.0" encoding="UTF-8" ?>
<ResultSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:yahoo:jp:jlp:DAService" xsi:schemaLocation="urn:yahoo:jp:jlp:DAService http://jlp.yahooapis.jp/DAService/V1/parseResponse.xsd">
  <Result>
    <ChunkList>
      <Chunk>
        <Id>0</Id>
        <Dependency>1</Dependency>
        <MorphemList>
          <Morphem>
            <Surface>私</Surface><Reading>わたし</Reading><Baseform>私</Baseform><POS>名詞</POS><Feature>名詞,名詞人,*,私,わたし,私</Feature>
          </Morphem>
          <Morphem>
            <Surface>の</Surface><Reading>の</Reading><Baseform>の</Baseform><POS>助詞</POS><Feature>助詞,助詞連体化,*,の,の,の</Feature>
          </Morphem>
        </MorphemList>
      </Chunk>
      <Chunk>
        <Id>1</Id>
        <Dependency>2</Dependency>
        <MorphemList>
          <Morphem>
            <Surface>名前</Surface><Reading>なまえ</Reading><Baseform>名前</Baseform><POS>名詞</POS><Feature>名詞,名詞,*,名前,なまえ,名前</Feature>
          </Morphem>
          <Morphem>
            <Surface>は</Surface><Reading>は</Reading><Baseform>は</Baseform><POS>助詞</POS><Feature>助詞,係助詞,*,は,は,は</Feature>
          </Morphem>
        </MorphemList>
      </Chunk>
      <Chunk>
        <Id>2</Id>
        <Dependency>-1</Dependency>
        <MorphemList>
          <Morphem>
            <Surface>ご</Surface><Reading>ご</Reading><Baseform>ご</Baseform><POS>接頭辞</POS><Feature>接頭辞,接頭ご,*,ご,ご,ご</Feature>
          </Morphem>
          <Morphem>
            <Surface>ん</Surface><Reading>ん</Reading><Baseform>ん</Baseform><POS>感動詞</POS><Feature>感動詞,感動,*,ん,ん,ん</Feature>
          </Morphem>
          <Morphem>
            <Surface>ご</Surface><Reading>ご</Reading><Baseform>ご</Baseform><POS>接頭辞</POS><Feature>接頭辞,接頭ご,*,ご,ご,ご</Feature>
          </Morphem>
          <Morphem>
            <Surface>です</Surface><Reading>で</Reading><Baseform>で</Baseform><POS>助動詞</POS><Feature>助動詞,助動詞です,基本形,です,で,で</Feature>
          </Morphem>
        </MorphemList>
      </Chunk>
    </ChunkList>
  </Result>
</ResultSet>
      EOS
    end

    #
    # 解析失敗した時に返ってくる XML
    #
    def self.failure
      <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<Error>
  <Message>error message</Message>
</Error>
      EOS
    end

    #
    # XML じゃないとしたら？
    #
    def self.no_xml
      'no XML!'
    end

    #
    # Yahoo Developer API の XML じゃないとしたら？
    #
    def self.no_yahoo_xml
      '<?xml version="1.0" encoding="UTF-8" ?><Hoge>ふが</Hoge>'
    end
  end
end
