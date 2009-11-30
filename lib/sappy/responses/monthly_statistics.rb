module Sappy
  module Responses
    class MonthlyStatistics < Response
      attr_reader :statistics

      def success
        @statistics = first_xpath('//dailystats')
      end
    end
  end
end
