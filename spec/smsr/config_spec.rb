require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Config, "fresh" do

  before(:each) do
    @test_file = "/tmp/suhv_test"
    
    File.delete(@test_file) if File.exists? @test_file
  end
  
  it "should create new file while saving"

  it "should initialize new config while loading" do
    c = SmsR::Config.load @test_file
    
    c.should be_instance_of(SmsR::Config)
  end
end

describe SmsR::Config, "existing" do
  it "should use file for saving"
  it "should read config while loading" 
  
  it "should check if the config version is compatible" 
end
