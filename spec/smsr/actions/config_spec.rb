require File.dirname(__FILE__) + '/../../spec_helper'

describe SmsR::Actions::Config do
  it "should respond to the config action"
  it "should list the configs entries when run with 0 argument"
  it "should list the provider's config entry when run with 1 argument"
  it "should save the provider's config entry when run with 3 argument"
end
