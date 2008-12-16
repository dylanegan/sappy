require File.dirname(__FILE__) + '/helper'

module Sappy
  describe Monitor do
    before do
      @account = Account.login("siteuptime-test@engineyard.com", "monitorey")
      @account.add_monitor("awesome", "http", "sf", "spork.in/awesome", "60")
      @monitor = @account.monitors.first
    end

    describe "an active monitor" do
      before do
        @monitor.enable
      end

      it "can be disabled" do
        @monitor.disable
        @monitor.active.should == "no"
      end
    end

    describe "an inactive monitor" do
      before do
        @monitor.disable
      end

      it "can be enabled" do
        @monitor.enable
        @monitor.active.should == "yes"
      end
    end

    describe "a monitor" do
      it "can be destroyed" do
        lambda { @monitor.destroy }.should.not.raise
      end
    end
  end
end
