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
    
    lambda { SubTest.run(to_test[0..1]) }.should raise_error(NoMethodError)
    lambda { SubTest.run(to_test << :test4) }.should raise_error(NoMethodError)
    
  end
  
  it "should call and create #run_0 if no argument is provided" do
    SmsR.stub!(:debug)
    
    $to_modify = false
    class SubTest < SmsR::Actions::RunnableAction
      runnable do
        $to_modify = true
      end
    end
    
    $to_modify.should be_false
    SubTest.run([])
    $to_modify.should be_true
  end
  it "should run the defined requirements in sequence" do
    SmsR::Actions::RunnableAction.should_receive(:first).and_return(true)
    SmsR::Actions::RunnableAction.should_receive(:second).and_return(false)
    SmsR::Actions::RunnableAction.should_not_receive(:third)
   
    class SubTest < SmsR::Actions::RunnableAction
      runnable :first, :second, :third do
      end
    end
    
    st = SubTest.new
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

    SubTest.run([2]).should be(4)
  end
  
  it "should should abort if one of the requirements isn't fulfilled"
end

describe SmsR::Actions::RunnableAction, "requirements" do
  it "should test #provider_config "
  
  it "should test #provider_itself "

end
