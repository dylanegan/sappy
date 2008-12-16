module Sappy
  class Account
    attr_reader :authkey, :available_monitors, :setup_monitors, :sms_alerts

    def self.login(username, password)
      account = new(username, password)
      account.login
      account
    end

    def initialize(username, password)
      @username, @password = username, password
    end

    def login
      connect
      refresh!
    end

    def authenticated?
      @authkey
    end

    def connect(forced = false)
      if !authenticated? or forced
        authenticate
      end
    end

    def refresh!
      response = request('accountinfo')
      @available_monitors = response.available_monitors
      @setup_monitors = response.setup_monitors
      @sms_alerts = response.sms_alerts
    end

    def monitors
      response = request('monitors')
      response.monitors.map do |m|
        Monitor.parse(self, m)
      end
    end

    def add_monitor(name, service, location, host, period)
      Monitor.create(self, name, service, location, host, period)
    end

    def request(action, parameters = {})
      Request.perform(self, action, parameters)
    end

    private
      def authenticate
        response = request('auth', "Email" => @username, "Password" => @password)
        @authkey = response.key
      end
  end
end
