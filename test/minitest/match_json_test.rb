require 'test_helper'

describe Minitest do
  describe 'Configuration' do
    it '#configure will override defaults' do
      Minitest::MatchJson.configure do |config|
        config.format = :color
        config.context = 1
      end
      Minitest::MatchJson.configuration.format.must_equal :color
      Minitest::MatchJson.configuration.context.must_equal 1
    end
  end

  describe 'Basic tests' do
    it 'compares some json' do
      json = '{"a": 2, "b": 4}'
      hash = { a: 2, b: 4 }
      json.must_match_json hash
    end

    it 'fails trying to compares a non json object' do
      json = '{"a": 2, "b": 4}'
      begin
        json.must_match_json 2
      rescue MiniTest::Assertion
        pass
      end
    end

    it 'returns a default result when failing' do
      Minitest::MatchJson.configure do |config|
        config.format = :text
      end

      json = '{"b": 5}'
      hash = { b: 4 }

      out, _ = capture_io do
        begin
          json.must_match_json hash.to_json
        rescue MiniTest::Assertion
          pass
        end
      end
      out.must_equal(<<STR

 {
-  \"b\": 4
+  \"b\": 5
 }
\\ No newline at end of file

STR
      )
    end

    it 'returns a default result with reduced context when failing' do
      Minitest::MatchJson.configure do |config|
        config.format = :text
        config.context = 1
      end

      json = '{"a": 3, "b": 5, "c": 5}'
      hash = { a: 3, b: 4, c: 5 }

      out, _ = capture_io do
        begin
          json.must_match_json hash.to_json
        rescue MiniTest::Assertion
          pass
        end
      end
      out.must_equal(<<STR

   \"a\": 3,
-  \"b\": 4,
+  \"b\": 5,
   \"c\": 5

STR
      )
    end

    it 'returns a colorized result when failing' do
      Minitest::MatchJson.configure do |config|
        config.format = :color
      end

      json = '{"b": 5}'
      hash = { b: 4 }

      out, _ = capture_io do
        begin
          json.must_match_json hash.to_json
        rescue MiniTest::Assertion
          pass
        end
      end
      out.must_equal(<<STR

 {
\e[31m-  \"b\": 4\e[0m
\e[32m+  \"b\": 5\e[0m
 }
\\ No newline at end of file

STR
      )
    end
  end
end
