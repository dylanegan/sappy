module Sappy
  class Actions
    def self.monitor_list
      Sappy::Request.new('monitors').perform.result.monitors
    end

    def self.disable_monitor(id)
      Sappy::Request.new('disablemonitor', "MonitorID=#{id}").perform
    end

    def self.enable_monitor(id)
      Sappy::Request.new('enablemonitor', "MonitorID=#{id}").perform
    end
  end
end
