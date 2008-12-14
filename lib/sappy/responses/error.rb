module Sappy
  module Responses
    class Error
      attr_reader :code, :message
      def initialize(xml)
        @code = xml["err"].first["code"]
        @message = xml["err"].first["msg"]
      end
    end
  end
end
