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
  
  it "should call the defined requirements in sequence" do
    SubTest.stub!(:a)
    SubTest.stub!(:b)

    SubTest.should_receive(:a)
    SubTest.should_receive(:b)
   
    class SubTest < SmsR::Actions::RunnableAction
      runnable :a, :b do |param|
        param*param
      end
    end
    
    SubTest.run []
  end
  
  it "should should abort if one of the requirements isn't fulfilled"
  
  it "should test #provider_config "
  
  it "should test #provider_itself "

end
