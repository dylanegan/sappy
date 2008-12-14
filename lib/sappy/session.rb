module Sappy
  class Session
    cattr_reader :key, :username, :password
    def self.setup(username, password)
      @@username = username
      @@password = password
      self.authenticate
    end

    def self.authenticate(forced = false)
      unless forced or self.authenticated?
        request = Sappy::Request.new('auth', "Email=#{@@username}&Password=#{@@password}")
        response = request.perform
        @@key = response.result.key
      end
    end

    def self.authenticated?
      @@key
    end
  end
end
