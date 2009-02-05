module Sappy
  class Monitor
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
    # SendUrlAlert (optional)
    #   0 or 1. Send Url (JSON) alerts on failures to Url specified on My Profile section. Default value is '0'. 
    # SendJabberAlert (optional)
    #   0 or 1. Send XMPP/Jabber alerts on failures to Jabber ID specified on My Profile section. Default value is '0'. 
    # Enabled (optional)
    #   0 or 1. Monitor is enabled on not. Default value is '1'. 
    # SendAlertAfter (optional)
    #   Send alerts after specified number of failures. Available values are: 1, 2, 3, 4, 5. Default value is 1.
    # Timeout (optional)
    #   Monitor socket connection timeout value in seconds. Available values are: 15, 20, 25, 30, 35. Default value is 25.
    attr_accessor :alt_email_alerts, :check_period, :content, :current_status, :domain, :dont_send_up_alert,
                  :enabled, :host_name, :id, :ip, :location, :login, :password, :name, :port_number, :service,
                  :send_alert_after, :send_all_down_alerts, :send_jabber_alert, :send_sms, :send_url_alert, :timeout
    attr_reader   :account
    alias :host :host_name
    alias :port :port_number

    def initialize(account, attrs)
      @account = account
      self.attributes = attrs
    end

    def self.parse(account, attrs)
      a = new(account, attrs)
      a.current_status = attrs["current_status"]
      a
    end

    def self.create(account, attrs)
      monitor = new(account, attrs)
      monitor.save
      monitor
    end

    def attributes
      { "Name" => name, "Service" => service, "Location" => location, "HostName" => host_name,
        "CheckPeriod" => check_period, "PortNumber" => port_number, "Login" => login, "Password" => password,
        "Content" => content, "Domain" => domain, "IP" => ip, "SendSms" => send_sms, "SendUrlAlert" => send_url_alert,
        "SendJabberAlert" => send_jabber_alert, "Enabled" => enabled, "SendAlertAfter" => send_alert_after, "Timeout" => timeout }
    end

    def attributes=(attrs)
      attrs.each do |attribute,value|
        send("#{attribute.to_s.underscore}=", value) if respond_to? "#{attribute.to_s.underscore}="
      end
    end

    def url
      "#{service}://#{host_name}"
    end

    def disable
      @account.request('disablemonitor', "MonitorId" => id)
      enabled = "no"
    end

    def enable
      @account.request('enablemonitor', "MonitorId" => id)
      enabled = "yes"
    end

    def new_record?
      id.nil?
    end

    def save
      new_record? ? create : update
    end

    def create
      @id = @account.request("addmonitor", attributes).id
    end

    def update
      @account.request("editmonitor", attributes.merge({ "MonitorId" => id }))
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
