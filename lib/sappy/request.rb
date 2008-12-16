require 'curb'

module Sappy
  class Request
    attr_reader :method, :parameters, :result, :response

    def initialize(method, parameters = "")
      @method = method
      @parameters = parameters
      perform
    end

    def perform
      request(@method, @parameters)
      @response
    end

    def request(method, parameters = "")
      parameters = "AuthKey=#{authkey}&#{parameters}" unless method == 'auth'
      uri = "https://siteuptime.com/api/rest/?method=siteuptime.#{method}&#{parameters}"
      @result = Curl::Easy.perform(uri)
      @response = Sappy::Response.new(self)
      @response.handle
    end

    private
      def authkey
        Sappy::Account.current.authkey
      end
  end
end
