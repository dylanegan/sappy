module SiteUptimeAPI
  module Responses
    class Monitor
      attr_reader :monitors
      def initialize(xml)
        @monitors = []
        xml["monitors"].first["monitor"].each do |monitor|
          @monitors << SiteUptimeAPI::Monitor.new(monitor)
        end
      end
    end
  end
end
