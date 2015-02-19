module Minitest
  module MatchJson
    # Configuration options passed to diffy
    class Configuration
      attr_accessor :format
      attr_accessor :context

      def initialize
        @format = :text
        @context = nil
      end
    end
  end
end
