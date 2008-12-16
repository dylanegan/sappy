module Sappy
  class Account
    attr_reader :authkey, :username, :password, :available_monitors, :setup_monitors, :sms_alerts
    cattr_accessor :current

    def initialize(username, password)
      @username = username
      @password = password
      connect
      Sappy::Account.current = self
      refresh!
    end

    def connect(forced = false)
      if !authenticated? or forced
        authenticate
      end
    end

    def refresh!
      response = Sappy::Request.new('accountinfo').perform
      @available_monitors = response.result.available_monitors
      @setup_monitors = response.result.setup_monitors
      @sms_alerts = response.result.sms_alerts
    end

    private
      def authenticate
        response = Sappy::Request.new('auth', "Email=#{@username}&Password=#{@password}").perform
        @authkey = response.result.key
      end

      def authenticated?
        @authkey
      end
  end
end
