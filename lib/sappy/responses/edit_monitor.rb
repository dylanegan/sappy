module Sappy
  module Responses
    class EditMonitor < Response
      def success(hash)
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
