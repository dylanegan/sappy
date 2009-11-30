module Sappy
  module Responses
    class SummaryStatistics < Response
      attr_reader :up, :down, :inactive

      def success
        node      = first_xpath('//summarystatistics')
        @up       = node['up'].to_i
        @down     = node['down'].to_i
        @inactive = node['inactive'].to_i
      end
    end
  end
end
