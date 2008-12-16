module Sappy
  module Responses
    class Monitors < Response
      attr_reader :monitors

      def success(hash)
        @monitors = []
        monitors = hash["monitors"]
        return if monitors.first["total"].to_i == 0

        monitors.first["monitor"].each do |monitor|
          @monitors << monitor
        end
      end
    end
  end
end
