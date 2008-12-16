module Sappy
  module Responses
    class AccountInfo < Response
      attr_reader :available_monitors, :setup_monitors, :sms_alerts

      def success(hash)
        accountinfo = hash["accountinfo"].first
        @available_monitors = accountinfo["availablemonitors"].to_i
        @setup_monitors = accountinfo["setupmonitors"].to_i
        @sms_alerts = accountinfo["smsalerts"].to_i
      end
    end
  end
end
