module Sappy
  class Response
    class SessionExpired < Error; end
    class UnhandledError < Error; end

    def self.parse(xml)
      r = new(xml)
      r.parse
      r
    end

    def initialize(xml)
      @xml = xml
    end

    def parse
      hash = XmlSimple.xml_in(@xml.to_s)
      if hash["stat"] == "fail"
        error = hash["err"]
        message = error.first["msg"]
        case code = error.first["code"]
        when "AUTH_EXPIRED"
          raise SessionExpired, "The auth session expired, reconnect to continue using the API"
        else
          failure(code, message)
          raise UnhandledError, "Unhandled error: #{code}, #{message}"
        end
      else
        success(hash)
      end
    end

    def success(hash)
      raise NotImplementedError, "Overwrite #success in a Response subclass"
    end

    def failure(code, message)
      raise NotImplementedError, "Overwrite #failure in a Response subclass"
    end
  end
end
