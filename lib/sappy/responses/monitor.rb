module Sappy
  module Responses
    class Monitor
      attr_reader :monitors
      def initialize(xml)
        @monitors = []
        xml["monitors"].first["monitor"].each do |monitor|
          @monitors << Sappy::Monitor.new(monitor)
        end unless xml["monitors"].first["total"].to_i == 0
      end
    end
  end
end
