module Sappy
  module Responses
    class AnnualStatistics < Response
      attr_reader :statistics

      def success(hash)
        @statistics = hash["monthlystats"].first
      end
    end
  end
end
