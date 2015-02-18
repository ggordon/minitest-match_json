gem 'minitest'
require 'minitest/autorun'
require 'minitest/match_json'

describe Minitest::Test do
  it 'compares some json' do
    json = '{"a": 2, "b": 4}'
    hash = { a: 2, b: 4 }
    json.must_match_json hash.to_json
  end
end
