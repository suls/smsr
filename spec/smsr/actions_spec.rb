require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Actions::RunnableAction do
  it "should call Instance#run by running Class#run" do
    SmsR.stub!(:debug)
    
    $to_modify = []
    class SubTest < SmsR::Actions::RunnableAction
      runnable do |test1, test2, test3|
        $to_modify = [test1, test2, test3]
      end
    end
    
    to_test = [:test1, :test2, :test3]
    SubTest.run(to_test)
    
    $to_modify.zip(to_test).each do |tuple|
      tuple.first.should eql(tuple.last)
    end
    
    lambda { SubTest.run(to_test[0..1]) }.
        should raise_error(NoMethodError)
        
    lambda { SubTest.run(to_test << :test4) }.
        should raise_error(NoMethodError)
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
  
  it "should run the defined requirements in sequence" do
    SmsR::Actions::RunnableAction.should_receive(:first).and_return(true)
    SmsR::Actions::RunnableAction.should_receive(:second).and_return(false)
    SmsR::Actions::RunnableAction.should_not_receive(:third)
   
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second, :third do |x|
      end
    end
    
    st = SubTest.new :x
    st.check.should be(false)
  end
  
  it "should run if all requirements are met" do
    SmsR::Actions::RunnableAction.stub!(:first).and_return(true)
    SmsR::Actions::RunnableAction.stub!(:second).and_return(true)
    
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second do |param|
        param*param
      end
    end

    SubTest.run(2).should be(4)
  end
  
  it "should not execute runnable" +
     "if one of the requirements isn't fulfilled" do
     SmsR::Actions::RunnableAction.stub!(:first).and_return(false)
     SmsR::Actions::RunnableAction.stub!(:second).and_return(true)

     class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second do
        throw :was_run
      end
     end

     lambda { SubTest.run }.should_not throw_symbol(:was_run)   
   end
end

describe SmsR::Actions::RunnableAction, "requirement #config" do
  
  before(:all) do
    @config = mock("Config")
    SmsR::Config.stub!(:load).and_return(@config)
  end
  
  it "should return false " +
     "if no config for provider :nonexisting_provider exists" do

    @config.should_receive(:[]).
           with(:nonexisting_provider).
           and_return(nil)

    SmsR::Actions::RunnableAction.
      config(:nonexisting_provider).first.should be(false)
  end

  it "#config should return 'true' "+
     "if config for provider :existing_provider exists" do
  
    @config.should_receive(:[]).
             with(:existing_provider).
             and_return(SmsR::OperatorConfig.new)
    
    SmsR::Actions::RunnableAction.
      config(:existing_provider).first.should be(true)
  end
        
  it "should print error when failing" do
    class SubTest < SmsR::Actions::RunnableAction
      runnable :config do
        throw :was_run
      end
    end
     
    @config.should_receive(:[]).
           with(:really_nonexisting_provider).
           and_return(nil)

    st = SubTest.new :really_nonexisting_provider
    st.check.should be(false)
    
    st.error.should be_instance_of(Array)
  end

  
  it "should have no error when succeding" do
    class SubErrorTest < SmsR::Actions::RunnableAction
      runnable :config do |p|
        throw :was_run
      end
    end
     
    @config.should_receive(:[]).
           with(:really_existing_provider).
           and_return(SmsR::OperatorConfig.new)
           
    lambda { SubErrorTest.run :really_existing_provider }.
      should throw_symbol(:was_run)
  end
end

describe SmsR::Actions::RunnableAction, "requirement #provider" do  
  before(:all) do
    prov_hash = {:existing_provider =>
                    SmsR::Providers::Provider.new(lambda {  } ) }
    SmsR::Providers.stub!(:providers).and_return(prov_hash)
  end
  
  it "should return 'true' for :existing_provider" do
    SmsR::Actions::RunnableAction.
      provider(:existing_provider).first.should be(true)
  end
  
  it "should return 'false' for :nonexisting_provider" do
    # SmsR::Providers.providers[@provider_name.to_sym]
    
    SmsR::Actions::RunnableAction.
      provider(:nonexisting_provider).first.should be(false)
  end
end

describe SmsR::Actions::RunnableAction, "requirement's error" do
  

  
  it "should be added for a failing #provider requirement" do
    pending
  end
  
  it "should printed instead of running the action"
end
