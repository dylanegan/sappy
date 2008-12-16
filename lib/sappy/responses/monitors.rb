module Sappy
  module Responses
    class Monitors < Response
      attr_reader :monitors

      def success(hash)
        @monitors = hash["monitors"].first["monitor"] || []
      end
    end
  end
end
