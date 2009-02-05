require File.dirname(__FILE__) + '/helper'

module Sappy
  describe Account do
    describe "with incorrect credentials" do
      it "raises an error" do
        lambda { Account.login("invalid", "password") }.
          should.raise(Responses::Auth::LoginFailed).
          message.should.match(/Wrong email or password/)
      end
    end

    describe "with correct credentials" do
      before do
        @account = Account.login("siteuptime-test@engineyard.com", "monitorey")
        @account.monitors.each do |m|
          m.destroy
        end
      end

      describe "with no monitors" do
        it "has details" do
          @account.available_monitors.should.be.kind_of Integer
          @account.setup_monitors.should.be.kind_of Integer
          @account.sms_alerts.should.be.kind_of Integer
        end

        it "has available monitors" do
          @account.available_monitors.should.not == 0
        end

        it "has no monitors" do
          @account.monitors.size.should == 0
        end

        it "can create a new monitor" do
          monitor = @account.add_monitor({:name => "awesome", :service => "http", :location => "sf", :host => "spork.in/awesome", :period => "60"})
          monitor.id.should.not.be.nil
          monitors = @account.monitors
          monitors.size.should == 1
          monitors.first.name.should == "awesome"
        end
      end
    end
  end
end
