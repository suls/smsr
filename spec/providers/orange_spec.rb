require File.dirname(__FILE__) + '/provider_helper'

describe "Orange" do
  it "should test the orange provider" do
    running :orange, "usr", "pwd", "num", "msg" do
      WWW::Mechanize.stub!(:new)
    end
    
    pending
  end
end
