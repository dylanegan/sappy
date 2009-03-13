module Sappy
  module Responses
    class SummaryStatistics < Response
      attr_reader :up, :down, :inactive

      def success(hash)
        hash["summarystatistics"].first.each do |stat,value|
          instance_variable_set("@#{stat}", value.to_i)
        end
      end
    end
  end
end
