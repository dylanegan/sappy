require 'rubygems'
require 'active_support'
require 'yaml'

$:.unshift File.dirname(__FILE__)

require 'site_uptime_api/actions'
require 'site_uptime_api/monitor'
require 'site_uptime_api/request'
require 'site_uptime_api/response'
require 'site_uptime_api/session'

config = YAML.load_file(File.dirname(__FILE__) + "/../config.yml")

SiteUptimeAPI::Session.setup(config["username"], config["password"])
