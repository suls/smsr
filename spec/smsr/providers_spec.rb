require File.dirname(__FILE__) + '/../spec_helper'

require 'fileutils'

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
  
  it "should generate Provider#call(N) when passed N arguments" do
    SmsR::Providers.provider :test_provider_with_args do |a,b|
      x = a*b
    end
    
    ret_val = SmsR::Providers.providers[:test_provider_with_args].call(42, 42)
    ret_val.should be(42*42)
  end
end

describe SmsR::Providers, "from file" do
  before(:each) do
    @provider_file = "/tmp/smsr_provider_test"
    # FileUtils.touch @provider_file
    FileUtils.rm @provider_file, :force => true
    provider_def = <<PD
    provider :test_provider_from_file do
      
    end
    
PD
    File.open(@provider_file, 'w') {|f| f.write(provider_def) }
  end
  
  after(:each) do
    FileUtils.rm @provider_file, :force => true
  end
  
  it "should load the provider specified in a file" do
    SmsR::Providers.load @provider_file, true
    
    SmsR::Providers.providers.should have(1).provider
    
    SmsR::Providers.providers[:test_provider_from_file].
      should be_instance_of(SmsR::Providers::Provider)
  end
  
  it "should load all the providers" do
    provider_name = :test_provider_2_from_file
    provider_def = <<PD
    provider :#{provider_name} do
      
    end
    
PD
    File.open(@provider_file, 'a') {|f| f.write(provider_def) }
    SmsR::Providers.load @provider_file, true
    
    SmsR::Providers.providers.should have(2).provider
    
    SmsR::Providers.providers[provider_name].
      should be_instance_of(SmsR::Providers::Provider)
  end
end
