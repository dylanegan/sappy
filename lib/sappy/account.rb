module Sappy
  class Account
    attr_reader :authkey, :available_monitors, :down_monitors, :inactive_monitors,
                :setup_monitors, :sms_alerts, :up_monitors

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
      refresh_account_info
      refresh_summary_statistics
    end

    def monitors(ids = [])
      params = ids.any? ? { "MonitorId" => ids.join(',') } : {}
      response = request('monitors', params)
      response.monitors.map do |m|
        Monitor.parse(self, m)
      end
    end

    def add_monitor(attributes)
      Monitor.create(self, attributes)
    end

    def request(action, parameters = {})
      Request.perform(self, action, parameters)
    end

    private
      def authenticate
        response = request('auth', "Email" => @username, "Password" => @password)
        @authkey = response.key
      end

      def refresh_account_info
        response = request('accountinfo')
        @available_monitors = response.available_monitors
        @setup_monitors = response.setup_monitors
        @sms_alerts = response.sms_alerts
      end

      def refresh_summary_statistics
        response = request('summarystatistics')
        @up_monitors = response.up
        @down_monitors = response.down
        @inactive_monitors = response.inactive
      end
  end
end
