require 'rubygems'
require 'bacon'
require 'fakeweb'
require 'pp'

require File.dirname(__FILE__) + '/../lib/sappy'

SPEC_DIR = File.dirname(__FILE__) unless defined? SPEC_DIR
$:<< SPEC_DIR
 
# Don't allow real web requests during specs!
FakeWeb.allow_net_connect = false

# Setup default URL calls

def cached_page(name)
  SPEC_DIR + "/xml/#{name}.xml"
end

FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?method=siteuptime.auth&Password=password&Email=valid%40email.com", :response => cached_page('valid_account'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?method=siteuptime.auth&Password=password&Email=invalid%40email.com", :response => cached_page('invalid_account'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.accountinfo", :response => cached_page('accountinfo'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.summarystatistics", :response => cached_page('summarystatistics'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?Name=New+Monitor&AuthKey=b7kks5mh1l300v5segaksm8gh3&Enabled=&HostName=new-sf-monitor.com&Login=&AltEmailAlerts=&Content=&Location=sf&EnablePublicStatistics=&Domain=&method=siteuptime.addmonitor&Timeout=&Password=&UpSubject=&AddToStatusPage=&SendAllDownAlerts=&IP=&SendAlertAfter=&DontSendUpAlert=&SendJabberAlert=&CheckPeriod=60&DownSubject=&SendUrlAlert=&SendSms=&PortNumber=&Service=http", :response => cached_page('addmonitor'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.enablemonitor&MonitorId=84043", :response => cached_page('enablemonitor'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.disablemonitor&MonitorId=84043", :response => cached_page('disablemonitor'))
FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.removemonitor&MonitorId=84043", :response => cached_page('removemonitor'))
