require 'rubygems'
require 'active_support'

$:.unshift File.dirname(__FILE__)

require 'site_uptime_api/actions'
require 'site_uptime_api/monitor'
require 'site_uptime_api/request'
require 'site_uptime_api/response'
require 'site_uptime_api/session'

module SiteUptimeAPI
  def self.setup(username, password)
    SiteUptimeAPI::Session.setup(username, password)
  end
end
