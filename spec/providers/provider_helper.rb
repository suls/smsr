require File.dirname(__FILE__) + '/../spec_helper'

def running(cmd, *args, &block)
  SmsR::Providers.load File.dirname(__FILE__) + 
                          "/../../lib/providers/#{cmd}.rb"
  block.call
  SmsR::Providers.providers[cmd].call args
end
