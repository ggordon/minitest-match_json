# require 'minitest/match_json/version'
require 'minitest/match_json/configuration'
require 'minitest/spec'
require 'json'
require 'diffy'

module Minitest
  # JSON matchers
  module MatchJson
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    def self.compare_json(actual_json, expected_json)
      Diffy::Diff.new(
        expected_json,
        actual_json,
        context: configuration.context
      ).to_s(configuration.format)
    end

    def self.pretty_json(param)
      json = (param.is_a?(String)) ? param : param.to_json
      JSON.pretty_generate(JSON.parse(json))
    end
  end

  # Assert style
  module Assertions
    #
    #  Fails unless +param and +actual have the same items.
    #
    def assert_match_json(expected, actual)
      match_json(expected, actual)
    end

    private

    # Helper to highlight diffs between two json strings
    def match_json(expected, actual)
      diff_str = Minitest::MatchJson.compare_json(
        pretty_json(actual), pretty_json(expected)
      )
      diff_str.strip.empty? ? match_json_passes : match_json_fails(diff_str)
    end

    def match_json_fails(diff_str)
      puts "\n#{diff_str}\n"
      flunk 'JSON did not match'
    end

    def match_json_passes
      pass 'JSON matched'
    end

    def pretty_json(param)
      Minitest::MatchJson.pretty_json(param)
    rescue StandardError
      flunk 'Parameter cannot be converted to JSON'
    end
  end

  # Spec style
  module Expectations
    #
    #  Fails unless the subject and parameter are equivalent JSON
    #
    infect_an_assertion :assert_match_json, :must_match_json
  end
end
