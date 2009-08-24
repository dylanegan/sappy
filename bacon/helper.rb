require 'rubygems'
require 'bacon'
require 'fakeweb'
require 'pp'
require 'rr'

require File.dirname(__FILE__) + '/../lib/sappy'

class Bacon::Context
  include RR::Adapters::RRMethods
end

shared :setup_and_teardown do
  before do
    #rr_reset
  end

  after do
    #rr_verify
    #rr_reset
  end
end
