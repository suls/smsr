require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::VERSION do
  it "should print the version string as MAYOR.MINOR.TINY" do
    v = "#{SmsR::VERSION::MAJOR}." +
        "#{SmsR::VERSION::MINOR}." +
        "#{SmsR::VERSION::TINY}"
    
    SmsR::VERSION::STRING.should eql(v)
  end
end