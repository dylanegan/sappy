require 'sappy/responses/auth'
require 'sappy/responses/account_info'
require 'sappy/responses/monitors'
require 'sappy/responses/add_monitor'
require 'sappy/responses/remove_monitor'

module Sappy
  module Responses
    MAP = {
      "auth" => Auth,
      "accountinfo" => AccountInfo,
      "monitors" => Monitors,
      "addmonitor" => AddMonitor,
      "removemonitor" => RemoveMonitor,
    }

    def self.for(action)
      MAP[action] || raise(ArgumentError, "Couldn't find a Response class to parse a #{action.inspect} result")
    end
  end
end
