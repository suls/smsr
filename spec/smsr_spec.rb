require File.dirname(__FILE__) + '/spec_helper'

describe SmsR, "option parser" do

  before(:all) do
    @null_output = File.new("/dev/null", "w")
    SmsR.stub!(:debug)
    SmsR.stub!(:info)
  end
  
  it "should enable debugging log by adding --debug cmd option" do
    SmsR.start(['--debug'], @null_output)
    SmsR.options.debug.should be_true
    
    SmsR.start(['-d'], @null_output)
    SmsR.options.debug.should be_true
  end
  
  it "should disable the debug log by default" do
    SmsR.start([])
    
    SmsR.options.debug.should be_false
  end
end

describe SmsR, "cmd line tools" do
  it "should add 'config' to args when smsr-config is invoked" do
    SmsR.stub!(:start)    
    SmsR.should_receive(:start).with(["config"])
    
    load File.dirname(__FILE__) + '/../bin/smsr-config'
  end
  
  it "should add 'send' to args when smsr-send is invoked" do
    SmsR.stub!(:start)    
    SmsR.should_receive(:start).with(["send"])
    
    load File.dirname(__FILE__) + '/../bin/smsr-send'
  end
end
