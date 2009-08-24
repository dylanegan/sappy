require File.dirname(__FILE__) + '/../helper'

module Sappy
  describe Monitor do
    before do
      @account = Account.login("valid@email.com", "password")
      @account.monitors.each { |m| m.destroy }
      @monitor = @account.add_monitor({:name => "New Monitor", :service => "http", :location => "sf", :host => "new-sf-monitor.com", :period => "60"})
    end

    describe "an active monitor" do
      before do
        @monitor.enable!
      end

      it "can be disabled" do
        @monitor.disable!
        @monitor.should.not.be.active
      end
    end

    describe "an inactive monitor" do
      before do
        @monitor.disable!
      end

      it "can be enabled" do
        @monitor.enable!
        @monitor.should.be.active
      end
    end

    describe "a monitor" do
      it "can be destroyed" do
        FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors_1'))
        @account.monitors.size.should == 1
        lambda { @monitor.destroy }.should.not.raise
        FakeWeb.register_uri(:get, "https://siteuptime.com/api/rest/?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors'))
        @account.monitors.size.should == 0
      end
    end
  end
end