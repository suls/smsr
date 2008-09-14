require File.dirname(__FILE__) + '/../spec_helper'

describe SmsR::Actions do
  it "should respond to the send action"
  it "should respond to the config action"
end

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
    
    lambda { SubTest.run(to_test[0..1]) }.should raise_error(ArgumentError)
    lambda { SubTest.run(to_test << :test4) }.should raise_error(ArgumentError)
    
  end
end
