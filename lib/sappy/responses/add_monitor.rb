module Sappy
  module Responses
    class AddMonitor < Response
      attr_reader :id

      def success
        node = first_xpath('//monitor')
        @id = node && node['id']
      end
    end
  end
end
