# require 'minitest/match_json/version'
require 'minitest/spec'
require 'json'
require 'diffy'
Diffy::Diff.default_format = :color

module Minitest
  module Assertions
    #
    #  Fails unless +param and +actual have the same items.
    #
    def assert_match_json(expected, actual)
      compare_json(expected, actual)
    end

    private

    # Helper to highlight diffs between two json strings
    def compare_json(expected, actual)
      expected_json = _convert_to_json(expected)
      actual_json = _convert_to_json(actual)
      actual_pretty = JSON.pretty_generate(JSON.parse(actual_json))
      expected_pretty = JSON.pretty_generate(JSON.parse(expected_json))
      diff =  Diffy::Diff.new(expected_pretty, actual_pretty)

      if diff.to_s.strip.empty?
        pass "JSON matched"
      else
        puts "\n#{diff}\n"
        flunk 'JSON did not match'
      end
    end

    def _convert_to_json(param)
      case param
      when String
        param
      when Hash
        param.to_json
      else
        flunk 'Expected parameter must be a String or a Hash'
      end
    end
  end


  module Expectations
    #
    #  Fails unless the subject and parameter are equivalent JSON
    #
    String.infect_an_assertion :assert_match_json, :must_match_json
    Hash.infect_an_assertion :assert_match_json, :must_match_json
  end

end
