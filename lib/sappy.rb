require 'rubygems'
require 'active_support'

$:.unshift File.dirname(__FILE__)

require 'sappy/actions'
require 'sappy/monitor'
require 'sappy/request'
require 'sappy/response'
require 'sappy/session'

module Sappy
  def self.setup(username, password)
    Sappy::Session.setup(username, password)
  end
end
