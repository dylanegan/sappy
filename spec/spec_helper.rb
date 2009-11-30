Bundler.require_env(:test)
require 'cgi'

ENV['LIVE_SPECS'] ||= 'false'

require File.dirname(__FILE__) + '/../lib/sappy'

begin
  require File.dirname(__FILE__) + '/credentials.rb'
rescue LoadError
  raise "add a spec/credentials.rb that defines USERNAME and PASSWORD constants"
end

Spec::Runner.configure do |config|
  def cached_page(name)
    file = File.dirname(__FILE__) + "/xml/#{name}.xml"
    File.exist?(file) ? file : fail("Unable to find #{file}")
  end

  def api_url
    'https://siteuptime.com/api/rest/'
  end

  def mocked?
    ENV['LIVE_SPECS'] == 'false'
  end
  config.before(:each) do
    if mocked?
      FakeWeb.allow_net_connect = false
      FakeWeb.clean_registry
      FakeWeb.register_uri(:get, "#{api_url}?method=siteuptime.auth&Password=#{PASSWORD}&Email=#{CGI.escape USERNAME}", :response => cached_page('valid_account'))
      FakeWeb.register_uri(:get, "#{api_url}?method=siteuptime.auth&Password=password&Email=invalid%40email.com", :response => cached_page('invalid_account'))
      FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.accountinfo", :response => cached_page('accountinfo'))
      FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.summarystatistics", :response => cached_page('summarystatistics'))
      FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors'))
      FakeWeb.register_uri(:get, "#{api_url}?AddToStatusPage=&AltEmailAlerts=&AuthKey=b7kks5mh1l300v5segaksm8gh3&CheckPeriod=60&Content=&Domain=&DontSendUpAlert=&DownSubject=&EnablePublicStatistics=&Enabled=&HostName=engineyard.com&IP=&Location=sf&Login=&Name=New+Monitor&Password=&PortNumber=&SendAlertAfter=&SendAllDownAlerts=&SendJabberAlert=&SendSms=&SendUrlAlert=&Service=http&Timeout=&UpSubject=&method=siteuptime.addmonitor", :response => cached_page('addmonitor'))
      FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.enablemonitor&MonitorId=84043", :response => cached_page('enablemonitor'))
      FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.disablemonitor&MonitorId=84043", :response => cached_page('disablemonitor'))
      FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.removemonitor&MonitorId=84043", :response => cached_page('removemonitor'))
    end
    Sappy::Account.login(USERNAME, PASSWORD).monitors.each do |m|
      m.destroy
    end
  end
end
