require File.dirname(__FILE__) + '/../../spec_helper'

describe SmsR::Actions::Send do
  it "should respond to the send action"
  it "should list the available providers when run with 0 argument"
  it "should send the sms using the give provider when run with 3 arguments"
end
