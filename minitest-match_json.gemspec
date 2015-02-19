# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/match_json/version'

Gem::Specification.new do |spec|
  spec.name          = 'minitest-match_json'
  spec.version       = Minitest::MatchJson::VERSION
  spec.authors       = ['Gary Gordon']
  spec.email         = ['gfgordon@gmail.com']
  spec.summary       = 'Compare two JSON objects'
  spec.description   = 'Compare two JSON objects with pretty diffs'
  spec.homepage      = 'http://ggordon.github.io/minitest-match_json'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9'

  spec.add_dependency 'diffy'
  spec.add_dependency 'json'
  spec.add_dependency 'minitest', '>= 4.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'simplecov'
end
