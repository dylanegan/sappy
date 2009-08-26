require File.dirname(__FILE__) + '/../helper'

module Sappy
  describe Account do
    describe "with incorrect credentials" do
      it "raises an error" do
        lambda { Account.login("invalid@email.com", "password") }.
          should.raise(Responses::Auth::LoginFailed).
          message.should.match(/Wrong email or password/)
      end
    end

    describe "with correct credentials" do
      before(:all) do
        @account = Account.login(USERNAME, PASSWORD)
      end
      
      before do
        @account.monitors.each do |m|
          m.destroy
        end
      end

      it "should obtain an auth key" do
        if ENV['LIVE_SPECS']
          @account.authkey.should.be.kind_of(String)
        else
          @account.authkey.should == "b7kks5mh1l300v5segaksm8gh3"
        end
      end

      describe "with no monitors" do
        it "has available monitors" do
          @account.available_monitors.should > 0
        end

        it "has no monitors" do
          @account.setup_monitors.should == 0
        end

        it "has no SMS alerts" do
          @account.sms_alerts.should == 0
        end

        it "can create a new monitor" do
          monitor = @account.add_monitor({:name => "New Monitor", :service => "http", :location => "sf", :host => "engineyard.com", :period => "60"})
          monitor.id.should.not.be.nil
          if ENV['LIVE_SPECS']
            @account.available_monitors.should == 2
          else
            FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors_1'))
          end
          monitors = @account.monitors
          monitors.size.should == 1
          monitors.first.name.should == "New Monitor"
        end
      end
    end
  end
end
