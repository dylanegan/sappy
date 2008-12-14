require File.dirname(__FILE__) + '/../helper'

class MockCurl
  def initialize(xml)
    @xml = xml
  end
  def body_str
    @xml
  end
end

describe "monitor_list" do
  before do
    xml = File.read(File.dirname(__FILE__) + '/../xml/monitor_list.xml')
    stub(Curl::Easy).perform.returns(MockCurl.new(xml))
  end

  it "should return a list of monitors" do
    monitors = Sappy::Actions.monitor_list
    monitors.should.be.kind_of Array
    monitors.first.should.be.kind_of Sappy::Monitor
  end
end
