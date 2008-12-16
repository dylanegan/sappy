module Sappy
  module Responses
    class Accountinfo
      attr_reader :available_monitors, :setup_monitors, :sms_alerts
      def initialize(xml)
        accountinfo = xml["accountinfo"].first
        @available_monitors = accountinfo["availablemonitors"]
        @setup_monitors = accountinfo["setupmonitors"]
        @sms_alerts = accountinfo["smsalerts"]
      end
    end
  end
end
