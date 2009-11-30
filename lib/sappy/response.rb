module Sappy
  class Response
    class SessionExpired < Error; end
    class UnhandledError < Error; end

    def self.parse(xml)
      r = new(xml)
      r.parse
      r
    end

    attr_reader :data, :xml

    def initialize(data)
      @data = data.to_s
      @xml  = Nokogiri::XML.parse(data)
    end

    def error_response?
      resp = xml.xpath('//rsp')
      resp && resp.first['stat'] == 'fail'
    end

    def error_response
      resp = xml.xpath('//err')
      resp && resp.first
    end

    def first_xpath(path)
      node = xml.xpath(path)
      node && node.first
    end

    def parse
      if error_response?
        error = error_response
        message = error["msg"]
        case code = error["code"]
        when "AUTH_EXPIRED"
          raise SessionExpired, "The auth session expired, reconnect to continue using the API"
        else
          failure(code, message)
          raise UnhandledError, "Unhandled error: #{code}, #{message}"
        end
      else
        success
      end
    end

    def success
      raise NotImplementedError, "Overwrite #success in a Response subclass"
    end

    def failure(code, message)
      case code
      when "WRONG_DATA"
        raise ArgumentError, "You didn't provide a correct monitor id: #{message}"
      else
        raise NotImplementedError, "Overwrite #failure in a Response subclass"
      end
    end
  end
end
