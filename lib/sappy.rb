require 'xmlsimple'

require File.dirname(__FILE__) + '/core_ext'

$:.unshift File.dirname(__FILE__)

module Sappy
  class Error < StandardError; end
end

require 'sappy/account'
require 'sappy/monitor'
require 'sappy/request'
require 'sappy/response'
require 'sappy/responses'
require 'sappy/statistics'
