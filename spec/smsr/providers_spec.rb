require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Providers do
  before(:each) do
    SmsR::Providers.provider :test_provider do
      x = 21+21
      x
    end
  end
  
  it "should generate a provider called :test_provider" do
  
    SmsR::Providers.providers[:test_provider].should be_instance_of(SmsR::Providers::Provider)
  end
  
  it "should generate Provider#call" do
    
    generated_prov = SmsR::Providers.providers[:test_provider]
    generated_prov.methods.include?("call").should be_true
  end
  
  it "should execute the code definded in the block" do
    
    ret_val = SmsR::Providers.providers[:test_provider].call
    ret_val.should be(42)
  end
end
