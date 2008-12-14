module SiteUptimeAPI
  class Actions
    def self.monitor_list
      SiteUptimeAPI::Request.new('monitors').perform.result.monitors
    end

    def self.disable_monitor(id)
      SiteUptimeAPI::Request.new('disablemonitor', "MonitorID=#{id}").perform
    end

    def self.enable_monitor(id)
      SiteUptimeAPI::Request.new('enablemonitor', "MonitorID=#{id}").perform
    end
  end
end
