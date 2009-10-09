module Sappy
  module Responses
    class MonthlyStatistics < Response
      attr_reader :statistics

      def success(hash)
        @statistics = hash["dailystats"].first
      end
    end
  end
end
