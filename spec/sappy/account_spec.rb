require File.dirname(__FILE__) + '/../spec_helper'

module Sappy
  describe Account do
    describe "with incorrect credentials" do
      it "raises an error" do
        lambda { Account.login("invalid@email.com", "password") }.
          should raise_error(Responses::Auth::LoginFailed, 'Wrong email or password')
      end
    end

    describe "with correct credentials" do
      before do
        @account = Account.login(USERNAME, PASSWORD)

        @account.monitors.each do |m|
          m.destroy
        end
      end

      it "should obtain an auth key" do
        if ENV['LIVE_SPECS']
          @account.authkey.should be_a_kind_of(String)
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
          monitor.id.should_not be_nil
          unless mocked?
            @account.available_monitors.should == MONITOR_LIMIT
          else
            FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page("monitors_#{MONITOR_LIMIT}"))
          end
          monitors = @account.monitors
          monitors.size.should == 1
          monitors.first.name.should == "New Monitor"
        end
      end
    end
  end
end
