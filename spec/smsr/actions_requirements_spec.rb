require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Actions::Requirements do
  
  before(:each) do
    Object.send(:remove_const, :SubTest) if defined? SubTest
  end
  
  after(:each) do
    Object.send(:remove_const, :SubTest) if defined? SubTest
  end
  
  
  it "should run the defined requirements in sequence" do
    helper = mock("RequirementsFoo")  
    helper.should_receive(:first).and_return(true)
    helper.should_receive(:second).and_return(false)
    helper.should_not_receive(:third)
    
    helper_mod = MixinMock.new(helper)
    
    SmsR::Actions.stub!(:requirements).and_return(helper_mod)
   
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second, :third do |needed|
      end
    end
    
    st = SubTest.new :p
    st.requirements = [:first, :second, :third]
    st.check.should be(false)
  end
end

describe SmsR::Actions::Requirements, "requirement #config" do

  before(:all) do
    Test = Class.new do
      attr_accessor :provider_name, :error
      include SmsR::Actions::Requirements
      
      def initialize
        @error = []
      end
    end
    @tester = Test.new
    @config = mock("Config")
  end
  
  after(:each) do
    @tester = nil
    @config = nil
    SmsR::Config.stub!(:load).and_return(nil)
  end
  
  it "should return false if no config for provider :nonexisting_provider exists" do
    @tester.provider_name = :nonexisting_provider
    
    @config.should_receive(:[]).
           with(:nonexisting_provider).
           and_return(nil)
    
    SmsR.stub!(:config).and_return(@config)
    
    @tester.config.should be(false)
  end

  it "should return 'true' if config for :existing_provider_1 exists" do
    @tester.provider_name = :existing_provider
    
    @config.should_receive(:[]).
             with(:existing_provider).
             and_return(true)

    SmsR.stub!(:config).and_return(@config)    
    
    @tester.config.should be(true)
  end
        
  it "should add an error to @error when failing" do
    @tester.provider_name = :nonexisting_provider

    @config.should_receive(:[]).
             with(:nonexisting_provider).
             and_return(nil)

    SmsR.stub!(:config).and_return(@config)    

    @tester.config
    
    @tester.error.size.should_not be(0) 
  end
end

describe SmsR::Actions::Requirements, "requirement #provider" do  
  
  include SmsR::Actions::Requirements
  
  before(:each) do
    @providers = mock("Providers")
    @provider_name = :blubb
    @error = []
  end
  
  it "should return false if no provider :nonexisting_provider exists" do
    
    @providers.should_receive(:[]).
           with(:nonexisting_provider).
           and_return(nil)
           
    SmsR::Providers.stub!(:providers).and_return(@providers)
    
    @provider_name = :nonexisting_provider
    
    provider.should be(false)
    
  end
  
  it "should return 'true' if provider :existing_provider exists" do
    @providers.should_receive(:[]).
           with(:existing_provider).
           and_return(true)
           
    SmsR::Providers.stub!(:providers).and_return(@providers)
    
    @provider_name = :existing_provider
    
    provider.should be(true)
  end
  
  it "should add an error to @error when failing" do
    @providers.should_receive(:[]).
           with(:existing_provider).
           and_return(true)
           
    SmsR::Providers.stub!(:providers).and_return(@providers)
    
    @provider_name = :existing_provider
    provider
    
    @error.size.should >= 1    
  end
end
