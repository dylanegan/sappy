require 'rest_client'
require 'rack'

module Sappy
  class Request
    def self.perform(account, action, parameters)
      new(account, action, parameters).perform
    end

    def initialize(account, action, parameters)
      @account, @action, @parameters = account, action, parameters
    end

    def perform
      xml = RestClient.get(uri)
      r = Responses.for(@action)
      r.parse(xml)
    end

    private
      def uri
        @uri ||= "https://siteuptime.com/api/rest/?#{query_string}"
      end

      def query_string
        if @account.authenticated?
          @parameters["AuthKey"] = @account.authkey
        end
        @parameters["method"] = "siteuptime.#{@action}"

        Rack::Utils.build_query(@parameters)
      end
  end
end
