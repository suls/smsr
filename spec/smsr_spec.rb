require File.dirname(__FILE__) + '/spec_helper'

describe SmsR, "option parser" do
  it "should enable debugging log by adding --debug cmd option" do
    SmsR.stub!(:start)
    
    SmsR.should be_debug
  end
  
  it "should disable the debug log by default" do
    SmsR.stub!(:start)
    
    SmsR.should_not be_debug
  end
end

describe SmsR::VERSION do
  it "should print the version string as MAYOR.MINOR.TINY" do
    v = "#{SmsR::VERSION::MAJOR}." +
        "#{SmsR::VERSION::MINOR}." +
        "#{SmsR::VERSION::TINY}"
        
    SmsR::VERSION::STRING.should eql(v)
  end
  
  it "should be the same as in the .gemspec" 
end
