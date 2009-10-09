module Sappy
  class Monitor
    # Name (required)
    #   Service name.
    # Service (required)
    #   Service type. Available values are: http, smtp, ftp, pop3, https, ping, dns
    SERVICES = %w(http smtp ftp pop3 https ping dns)
    # Location (required)
    #   Check location. Available values are: sf, ny, ch, ln (i.e. San Francisco, New York, Chicago, London).
    LOCATIONS = {'sf' => 'San Francisco', 'ny' => 'New York', 'ch' => 'Chicago', 'ln' => 'London'}.sort
    # HostName (required)
    #   Monitored Host name, IP or Page URL.
    # CheckPeriod (required)
    #   Monitoring check period. Available values are: 2, 5, 15, 30, 60
    CHECK_PERIODS = [2, 5, 15, 30, 60]
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
    # AltEmailAlerts (optional)
    #   Alternative Email alerts addresses separated with comma.
    # DontSendUpAlert (optional)
    #   0 or 1. Set to 1 if you do not what to receive Up alerts for a monitor. Default value is '0'.
    # SendAllDownAlerts (optional)
    #   0 or 1. Set to 1 if you what to receive Down alert on each failure check. Default value is '0'.
    # Enabled (optional)
    #   0 or 1. Monitor is enabled on not. Default value is '1'. 
    # SendAlertAfter (optional)
    #   Send alerts after specified number of failures. Available values are: 1, 2, 3, 4, 5. Default value is 1.
    SEND_ALERT_AFTER = [1, 2, 3, 4, 5]
    # DownSubject (optional)
    #   Email subject value for Down alerts. Default subject will be used if empty.
    # UpSubject (optional)
    #   Email subject value for Up alerts. Default subject will be used if empty.
    # EnablePublicStatistics (optional)
    #   0 or 1. Allow/Deny visitor to see public statistics report. Default value is '1' (allow).
    # AddToStatusPage (optional)
    #   0 or 1. Add/remove monitor to/from your public summary status report. Default value is '1' (add). 
    # Timeout (optional)
    #   Monitor socket connection timeout value in seconds. Available values are: 15, 20, 25, 30, 35. Default value is 25.
    TIMEOUTS = [15, 20, 25, 30, 35]

    attr_accessor :altemailalerts, :content, :current_status, :domain,
                  :downsubject, :host, :id, :ip, :location, :login,
                  :password, :period, :port, :name, :service, :timeout, :upsubject
    boolean_accessor :active, :addtostatuspage, :dontsendupalert, :enablepublicstatistics, 
                  :sendalertafter, :sendalldownalerts, :sendjabberalert, :sendsms, :sendurlalert
    attr_reader   :account

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
      { "Name" => name, "Service" => service, "Location" => location, "HostName" => host,
        "CheckPeriod" => period, "PortNumber" => port, "Login" => login, "Password" => password,
        "Content" => content, "Domain" => domain, "IP" => ip, "SendSms" => sendsms, "SendUrlAlert" => sendurlalert,
        "SendJabberAlert" => sendjabberalert, "AltEmailAlerts" => altemailalerts, "DontSendUpAlert" => dontsendupalert,
        "SendAllDownAlerts" => sendalldownalerts, "Enabled" => active, "SendAlertAfter" => sendalertafter,
        "DownSubject" => downsubject, "UpSubject" => upsubject, "EnablePublicStatistics" => enablepublicstatistics,
        "AddToStatusPage" => addtostatuspage, "Timeout" => timeout }
    end

    def attributes=(attrs)
      attrs.each do |attribute,value|
        send("#{attribute.to_s}=", value) if respond_to? "#{attribute.to_s}="
      end
    end

    def id=(value)
      @id = value.to_i
    end

    def url
      "#{service}://#{host}"
    end

    def disable!
      @account.request('disablemonitor', "MonitorId" => id)
      @active = 0
    end

    def enable!
      @account.request('enablemonitor', "MonitorId" => id)
      @active = 1
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

    def daily_statistics(year, month, day)
      Statistics::Daily.new(@account.request('dailystatistics', "MonitorId" => id, "Year" => year, "Month" => month, "Day" => day).statistics)
    end

    def monthly_statistics(year, month)
      Statistics::Monthly.new(@account.request('monthlystatistics', "MonitorId" => id, "Year" => year, "Month" => month).statistics)
    end

    def annual_statistics(year = "")
      Statistics::Annual.new(@account.request('annualstatistics', "MonitorId" => id, "Year" => year).statistics)
    end
  end
end
