require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Config, "fresh" do

  before(:each) do
    @mock_config_file = mock(File)    
    
  end
  
  it "should create new file while saving"

  it "should initialize new config while loading" do
    File.stub!(:exists?).and_return(false)
    SmsR::Config.should_receive(:new).
                with(@mock_config_file).
                and_return(42)
    
    c = SmsR::Config.load @mock_config_file
    
    c.should equal(42)
    
  end
end

describe SmsR::Config, "existing" do
  it "should use file for saving"
  it "should read config while loading" 
  
  it "should check if the config version is compatible" 
end
