# Minitest::MatchJson

[![Build Status](https://travis-ci.org/ggordon/minitest-match_json.svg?branch=master)](https://travis-ci.org/ggordon/minitest-match_json) [![Gem Version](https://badge.fury.io/rb/minitest-match_json.svg)](http://badge.fury.io/rb/minitest-match_json) [![Code Climate](https://codeclimate.com/github/ggordon/minitest-match_json/badges/gpa.svg)](https://codeclimate.com/github/ggordon/minitest-match_json) [![Test Coverage](https://codeclimate.com/github/ggordon/minitest-match_json/badges/coverage.svg)](https://codeclimate.com/github/ggordon/minitest-match_json)

Compare a JSON string to another JSON object. If a String is passed in, it is expected to be valid JSON, any other type will be converted to json if possible.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-match_json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-match_json

## Usage

```
require 'minitest-match_json'
```

[Diffy](https://github.com/samg/diffy) is used to compare the two JSON objects. Options to control the output format and number of context lines to be displayed can be passed through to Diffy.

```ruby
Minitest::MatchJson.configure do |config|
  config.format = :color
  config.context = 1
end
```

### Assert style
```ruby
assert_match_json expected_json, actual_json
```

### Spec style
```ruby
actual_json.must_match_json expected_json
```

## Contributing

1. Fork it ( https://github.com/ggordon/minitest-match_json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
