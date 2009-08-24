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
      before do
        @account = Account.login("valid@email.com", "password")
        @account.monitors.each do |m|
          m.destroy
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
          monitor = @account.add_monitor({:name => "New Monitor", :service => "http", :location => "sf", :host => "new-sf-monitor.com", :period => "60"})
          monitor.id.should.not.be.nil
          FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors_1'))
          monitors = @account.monitors
          monitors.size.should == 1
          monitors.first.name.should == "New Monitor"
        end
      end
    end
  end
end
