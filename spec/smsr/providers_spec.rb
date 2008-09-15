require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Providers do
  it "should generate a provider called :test" do
    SmsR::Providers.provider :test0r do
     "jajajajajajjajaja"
    end
    
    SmsR::Providers.test0r.should eql("jajajajajajjajaja")
  end
end
