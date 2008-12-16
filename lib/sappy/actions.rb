module Sappy
  class Actions
    def self.disable_monitor(id)
      Sappy::Request.new('disablemonitor', "MonitorID=#{id}").perform
    end

    def self.enable_monitor(id)
      Sappy::Request.new('enablemonitor', "MonitorID=#{id}").perform
    end

    def self.account_information
      raise "Not yet implemented."
    end

    def self.add_monitor
      raise "Not yet implemented."
    end

    def self.remove_monitor
      raise "Not yet implemented."
    end

    def self.daily_statistics
      raise "Not yet implemented."
    end

    def self.monthly_statistics
      raise "Not yet implemented."
    end

    def self.annual_statistics
      raise "Not yet implemented."
    end
  end
end
