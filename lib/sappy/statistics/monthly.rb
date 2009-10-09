module Sappy
  module Statistics
    class Monthly
      attr_reader :checks, :failures, :month, :timezone, :total, :uptime, :year

      def initialize(attributes = {})
        @checks = attributes[:numchecks]
        @failures = attributes[:numfailures]
        @month = attributes[:month]
        @timezone = attributes[:timezone]
        @total = attributes[:total]
        @uptime = attributes[:uptime]
        @year = attributes[:year]
      end
    end
  end
end
