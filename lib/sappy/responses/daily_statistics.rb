module Sappy
  module Responses
    class DailyStatistics < Response
      attr_reader :statistics

      def success(hash)
        @statistics = hash["checks"].first
      end
    end
  end
end
