require 'rubygems'
#require 'active_support'

$:.unshift File.dirname(__FILE__)

module Sappy
  class Error < StandardError; end
end

require 'sappy/account'
require 'sappy/monitor'
require 'sappy/request'
require 'sappy/response'
require 'sappy/responses'
require 'sappy/version'
