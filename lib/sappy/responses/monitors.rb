module Sappy
  module Responses
    class Monitors < Response
      attr_reader :monitors

      def success
        @monitors = xml.xpath('//monitors/monitor')
      end
    end
  end
end
