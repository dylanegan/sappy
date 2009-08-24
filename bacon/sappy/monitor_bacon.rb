require File.dirname(__FILE__) + '/../helper'

module Sappy
  describe Monitor do
    before do
      @account = Account.login("siteuptime-test@engineyard.com", "monitorey")
      @account.monitors.each { |m| m.destroy }
      @monitor = @account.add_monitor({:name => "awesome", :service => "http", :location => "sf", :host => "spork.in/awesome", :period => "60"})
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
        lambda { @monitor.destroy }.should.not.raise
        @account.monitors.size.should == 0
      end
    end
  end
end
