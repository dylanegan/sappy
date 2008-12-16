module Sappy
  module Responses
    class AccountInfo < Response
      attr_reader :available_monitors, :setup_monitors, :sms_alerts

      def success(hash)
        accountinfo = hash["accountinfo"].first
        @available_monitors = accountinfo["availablemonitors"]
        @setup_monitors = accountinfo["setupmonitors"]
        @sms_alerts = accountinfo["smsalerts"]
      end
    end
  end
end
