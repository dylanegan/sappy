require File.dirname(__FILE__) + '/../spec_helper'

module Sappy
  describe Monitor do
    before do
      @account = Account.login(USERNAME, PASSWORD)
    end

    before do
      @account.monitors.each { |m| m.destroy }
      @monitor = @account.add_monitor(:name => "New Monitor", :service => "http", :location => "sf", :host => "engineyard.com", :period => "60")
    end

    describe "an active monitor" do
      before do
        @monitor.enable!
      end

      it "can be disabled" do
        @monitor.disable!
        @monitor.should be_disabled
      end
    end

    describe "an inactive monitor" do
      before do
        @monitor.disable!
      end

      it "can be enabled" do
        @monitor.enable!
        @monitor.should be_enabled
      end
    end

    describe "a monitor" do
      it "can be destroyed" do
        if mocked?
          FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors_1'))
        end
        @account.monitors.size.should == 1
        lambda { @monitor.destroy }.should_not raise_error #TODO
        if mocked?
          FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.monitors", :response => cached_page('monitors'))
        end
        @account.monitors.size.should == 0
      end

      describe "statistics" do
        before do
          if mocked?
            FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&Month=11&method=siteuptime.dailystatistics&Day=28&Year=2006&MonitorId=84043", :response => cached_page('dailystatistics'))
            FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&Month=6&method=siteuptime.monthlystatistics&Year=2007&MonitorId=84043", :response => cached_page('monthlystatistics'))
            FakeWeb.register_uri(:get, "#{api_url}?AuthKey=b7kks5mh1l300v5segaksm8gh3&method=siteuptime.annualstatistics&Year=&MonitorId=84043", :response => cached_page('annualstatistics'))
          end
          @monitor = @account.add_monitor({:name => "New Monitor", :service => "http", :location => "sf", :host => "engineyard.com", :period => "60"})
        end

        it "should provide daily" do
          @monitor.daily_statistics(2006, 11, 28).should be_an_instance_of(Statistics::Daily)
        end

        it "should provide monthly" do
          @monitor.monthly_statistics(2007, 6).should be_an_instance_of(Statistics::Monthly)
        end

        it "should provide annual" do
          @monitor.annual_statistics.should be_an_instance_of(Statistics::Annual)
        end
      end
    end
  end
end
