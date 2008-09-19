require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Actions::RunnableAction do
  
  before(:each) do
    Object.send(:remove_const, :SubTest) if defined? SubTest
  end
  
  after(:each) do
    Object.send(:remove_const, :SubTest) if defined? SubTest
  end
  
  it "should call Instance#run_N by running Class#run(N)" do
    SmsR.stub!(:debug)
    
    class SubTest < SmsR::Actions::RunnableAction
      runnable do
        throw :none
      end
      
      runnable do |one|
        throw one.to_sym
      end
            
      runnable do |one, two|
        throw two.to_sym
      end
      
      runnable do |one, two, three|
        throw three.to_sym
      end
    end
    
    lambda { SubTest.run }.should throw_symbol(:none)
    lambda { SubTest.run :one }.should throw_symbol(:one)
    lambda { SubTest.run :one, :two}.should throw_symbol(:two)
    lambda { SubTest.run :one, :two, :three}.should throw_symbol(:three)
  end
  
  it "should call and create #run_0 if no argument is provided" do
    SmsR.stub!(:debug)
    
    class SuperSubTest < SmsR::Actions::RunnableAction
      runnable do
        throw :run
      end
    end
    
    lambda { SuperSubTest.run }.should throw_symbol(:run)
  end
  
  it "should run if all requirements are met" do
    helper = mock("Requirements")  
    helper.should_receive(:first).and_return(true)
    helper.should_receive(:second).and_return(true)
    
    helper_mod = MixinMock.new(helper)
    
    SmsR::Actions.stub!(:requirements).and_return(helper_mod)
        
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second do
        throw :was_run
      end
    end

    lambda { SubTest.run }.should throw_symbol(:was_run)    
  end
  
  it "should not execute runnable requirements isn't fulfilled" do
    helper = mock("Requirements2")  
    helper.should_receive(:first).and_return(true)
    helper.should_receive(:second).and_return(false)

    helper_mod = MixinMock.new(helper)

    SmsR::Actions.stub!(:requirements).and_return(helper_mod)

    class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second do
        throw :was_run_but_shouldnt
      end
    end

    lambda { SubTest.run }.should_not throw_symbol(:was_run_but_shouldnt)   
  end
   
end

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
#   
  before(:each) do
    class Test 
      attr_accessor :provider_name
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

  it "should return 'true' if config for :existing_provider exists" do
    @tester.provider_name = :mongo
    
    @config.should_receive(:[]).
             with(:mongo).
             and_return(true)

    SmsR.stub!(:config).and_return(@config)    
    
    @tester.config.should be(true)
  end
#         
#   it "should print error when failing" do
#     class SubTest < SmsR::Actions::RunnableAction
#       runnable :config do
#         throw :was_run
#       end
#     end
#      
#     @config.should_receive(:[]).
#            with(:really_nonexisting_provider).
#            and_return(nil)
# 
#     st = SubTest.new :really_nonexisting_provider
#     st.check.should be(false)
#     
#     st.error.should be_instance_of(Array)
#   end
# 
#   
#   it "should have no error when succeding" do
#     class SubErrorTest < SmsR::Actions::RunnableAction
#       runnable :config do |p|
#         throw :was_run
#       end
#     end
#      
#     @config.should_receive(:[]).
#            with(:really_existing_provider).
#            and_return(SmsR::OperatorConfig.new)
#            
#     lambda { SubErrorTest.run :really_existing_provider }.
#       should throw_symbol(:was_run)
#   end
end
# 
# describe SmsR::Actions::RunnableAction, "requirement #provider" do  
#   before(:all) do
#     prov_hash = {:existing_provider =>
#                     SmsR::Providers::Provider.new(lambda {  } ) }
#     SmsR::Providers.stub!(:providers).and_return(prov_hash)
#   end
#   
#   it "should return 'true' for :existing_provider" do
#     SmsR::Actions::RunnableAction.
#       provider(:existing_provider).first.should be(true)
#   end
#   
#   it "should return 'false' for :nonexisting_provider" do
#     # SmsR::Providers.providers[@provider_name.to_sym]
#     
#     SmsR::Actions::RunnableAction.
#       provider(:nonexisting_provider).first.should be(false)
#   end
# end
# 
# describe SmsR::Actions::RunnableAction, "requirement's error" do
#   
# 
#   
#   it "should be added for a failing #provider requirement" do
#     pending
#   end
#   
#   it "should printed instead of running the action"
# end
