module SiteUptimeAPI
  module Responses
    class Auth
      attr_reader :key
      def initialize(xml)
        @key = xml["session"].first["key"]
      end
    end
  end
end
