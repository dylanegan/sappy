module Sappy
  module Responses
    class DailyStatistics < Response
      attr_reader :statistics

      def success
        @statistics = first_xpath('//checks')
      end
    end
  end
end
