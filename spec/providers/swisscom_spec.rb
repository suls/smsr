require File.dirname(__FILE__) + '/provider_helper'

describe SmsR::Providers::Provider, "Swisscom" do
  it "should test the swisscom provider" do
    running :swisscom, "usr", "pwd", "num", "msg" do
      WWW::Mechanize.stub!(:new)
    end
    
    pending
  end
  
end
