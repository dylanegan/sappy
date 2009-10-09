module Sappy
  module Statistics
    class Daily
      attr_reader :checks, :failures, :timezone, :total, :uptime

      def initialize(attributes = {})
        @checks = attributes[:numchecks]
        @failures = attributes[:numfailures]
        @timezone = attributes[:timezone]
        @total = attributes[:total]
        @uptime = attributes[:uptime]
      end
    end
  end
end
