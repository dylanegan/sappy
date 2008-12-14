require 'rubygems'
require 'bacon'
require 'rr'
require File.dirname(__FILE__) + '/../lib/site_uptime_api'
SiteUptimeAPI::setup('admin@engineyard.com', 'monitorey')

class Bacon::Context
  include RR::Adapters::RRMethods
end

shared :setup_and_teardown do
  before do
    rr_reset
  end

  after do
    rr_verify
    rr_reset
  end
end
