module Sappy
  class Monitor
    attr_reader :name, :period, :service, :port, :id, :current_status, :host, :active
    def initialize(params = {})
      params.each do |param, value|
       instance_variable_set("@#{param}", value)
      end
    end

    def disable
      Sappy::Request.new('disablemonitor', "MonitorID=#{self.id}").perform
    end

    def enable
      Sappy::Request.new('enablemonitor', "MonitorID=#{self.id}").perform
    end

    # add_monitor
    def save
      raise "Not yet implemented."
    end

    # remove_monitor
    def destroy
      raise "Not yet implemented."
    end

    def daily_statistics
      raise "Not yet implemented."
    end

    def monthly_statistics
      raise "Not yet implemented."
    end

    def annual_statistics
      raise "Not yet implemented."
    end
  end
end
