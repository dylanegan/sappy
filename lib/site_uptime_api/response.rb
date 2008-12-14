require 'xmlsimple'
require 'site_uptime_api/responses'

module SiteUptimeAPI
  class Response
    attr_reader :result, :status

    def initialize(request)
      @request = request
    end

    def handle
      parse!
      if self.fail?
        handle_fail_whale
      end
    end

    def parse!
      xml = XmlSimple.xml_in(@request.result.body_str)
      @status = xml["stat"]
      if self.fail?
        @result = SiteUptimeAPI::Responses::Error.new(xml)
      else
        @result = "SiteUptimeAPI::Responses::#{@request.method.classify}".constantize.new(xml)
      end
    end

    def fail?
      @status == "fail"
    end

    def handle_fail_whale
      case @result.code
        when "AUTH_EXPIRED"
          Session.authenticate(true)
          @request.perform
        when "AUTH_ERR"
          raise "Authentication Error: #{@result.message}"
      end
    end
  end
end
