module Sappy
  class Monitor
    def self.parse(account, hash)
      a = new(account, hash["id"], hash["name"], hash["host"], hash["port"], hash["service"], hash["active"], hash["period"])
      a.current_status = hash["current_status"]
      a
    end

    # AuthKey (required)
    #   Authentication key returned by ‘siteuptime.auth’ method.
    # Name (required)
    #   Service name.
    # Service (required)
    #   Service type. Available values are: http, smtp, ftp, pop3, https, ping, dns
    # Location (required)
    #   Check location. Available values are: sf, ny, ch, ln (i.e. San Francisco, New York, Chicago, London). 
    # HostName (required)
    #   Monitored Host name, IP or Page URL.
    # CheckPeriod (required)
    #   Monitoring check period. Available values are: 2, 5, 15, 30, 60
    # PortNumber (optional)
    #   Custom port number. Default service port using by default.
    # Login (optional)
    #   HTTP Authentication login. Used for 'http' and https services only.
    # Password (optional)
    #   HTTP Authentication password. Used for 'http' and https services only.
    # Content (optional)
    #   Monitored page content. Used for 'http' and 'https' services only.
    # Domain (optional)
    #   Lookup domain. Used for 'dns' services only.
    # IP (optional)
    #   Lookup domain. Used for 'dns' services only. Required if 'Domain' is not empty.
    # SendSms (optional)
    #   0 or 1. Send SMS alerts on failures. Default value is '0'. 
    # Enabled (optional)
    #   0 or 1. Monitor is enabled on not. Default value is '1'. 
    # SendAlertAfter (optional)
    #   Send alerts after specified number of failures. Available values are: 1, 2, 3, 4, 5. Default value is 1.
    # Timeout (optional)
    #   Monitor socket connection timeout value in seconds. Available values are: 15, 20, 25, 30, 35. Default value is 25.
    def self.create(account, name, service, location, host, period)
      account.request("addmonitor", "Name" => name, "Service" => service,
                      "Location" => location, "HostName" => host,
                      "CheckPeriod" => period, "Enabled" => "0")
    end

    def initialize(account, id, name, host, port, service, active, period)
      @account = account
      @id, @name, @host, @port, @service = id, name, host, port, service
      @active, @period, @current_status = active, period, current_status
    end
    attr_reader :id, :name, :host, :port, :service, :active, :period
    attr_accessor :current_status

    def disable
      @account.request('disablemonitor', "MonitorId" => id)
      @active = "no"
    end

    def enable
      @account.request('enablemonitor', "MonitorId" => id)
      @active = "yes"
    end

    def save
      raise "Not yet implemented."
    end

    def destroy
      @account.request('removemonitor', "MonitorId" => id)
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
