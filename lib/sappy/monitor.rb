module Sappy
  class Monitor
    attr_reader :name, :period, :service, :port, :id, :current_status, :host, :active
    def initialize(params = {})
      params.each do |param, value|
       instance_variable_set("@#{param}", value)
      end
    end
  end
end
