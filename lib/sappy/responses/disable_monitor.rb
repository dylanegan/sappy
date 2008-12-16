module Sappy
  module Responses
    class DisableMonitor < Response
      def success(hash)
      end

      def failure(code, message)
        case code
        when "WRONG_DATA"
          raise ArgumentError, "You didn't provide a correct monitor id: #{message}"
        end
      end
    end
  end
end
