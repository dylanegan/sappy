module Sappy
  class Request
    def self.perform(account, action, parameters)
      new(account, action, parameters).perform
    end

    def initialize(account, action, parameters)
      @account, @action, @parameters = account, action, parameters
    end

    def perform
      response = http.get("#{uri.path}?#{query_string}")
      Responses.for(@action).parse(response.body)
    end

    private
      def uri
        @uri ||= URI("https://siteuptime.com/api/rest/?#{query_string}")
      end

      def query_string
        if @account.authenticated?
          @parameters["AuthKey"] = @account.authkey
        end
        @parameters["method"] = "siteuptime.#{@action}"

        Rack::Utils.build_query(@parameters)
      end

      def http
        http             = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl     = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http
      end
  end
end
