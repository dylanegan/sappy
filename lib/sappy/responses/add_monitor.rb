module Sappy
  module Responses
    class AddMonitor < Response
      attr_reader :id
      def success(hash)
        @id = hash["monitor"].first["id"]
      end

      def failure(code, message)
        case code
        when "WRONG_DATA"
          raise ArgumentError, "You didn't provide the correct data: #{message}"
        end
      end
    end
  end
end
