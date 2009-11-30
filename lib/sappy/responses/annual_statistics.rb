module Sappy
  module Responses
    class AnnualStatistics < Response
      attr_reader :statistics

      def success
        @statistics = first_xpath('//monthlystats')
      end
    end
  end
end
