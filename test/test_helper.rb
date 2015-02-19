require 'codeclimate-test-reporter'
CodeClimate::TestReporter.configuration.git_dir = '.'
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start

gem 'minitest'
require 'minitest/autorun'
require 'minitest/match_json'
