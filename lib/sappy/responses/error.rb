module Sappy
  module Responses
    class ErrorResponse
      class Error < StandardError; end
      class AuthenticationError < Error; end

      def initialize(xml)
        err = xml["err"]
        message = err.first["msg"]

        case code = err.first["code"]
        when "AUTH_EXPIRED"
          raise AuthenticationExpired, message
        when "AUTH_ERR"
          raise AuthenticationError, message
        else
          raise Error, "Unknown error[#{code}]: #{message}"
        end
      end
    end
  end
end
