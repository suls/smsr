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

  it "should print the error if execution failed" do    
    helper = mock("Requirements")
    helper.should_receive(:first).and_return(false)

    helper_mod = MixinMock.new(helper)

    SmsR::Actions.stub!(:requirements).and_return(helper_mod)
    SmsR.stub!(:info)
    SmsR.should_receive(:info)
    
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first do
        throw :was_run_but_shouldnt
      end
    end
    
    SubTest.run
  end
  
  it "should not print the error if execution succeded" do    
    helper = mock("Requirements")
    helper.should_receive(:first).and_return(true)

    helper_mod = MixinMock.new(helper)

    SmsR::Actions.stub!(:requirements).and_return(helper_mod)

    SmsR.should_not_receive(:info)
    
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first do
        nil
      end
    end
    
    SubTest.run
  end
end
