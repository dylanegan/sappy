module Sappy
  module Responses
    class Error
      attr_reader :code, :message
      def initialize(xml)
        @code = xml["err"].first["code"]
        @message = xml["err"].first["message"]
      end
    end
  end
end
