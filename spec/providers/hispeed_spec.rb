require File.dirname(__FILE__) + '/provider_helper'

describe "Hispeed" do
  it "should test the orange provider" do
    running :hispeed, "usr", "pwd", "num", "msg" do
      WWW::Mechanize.stub!(:new)
    end
    
    pending
  end
end
