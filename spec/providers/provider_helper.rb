require File.dirname(__FILE__) + '/../spec_helper'

def running(cmd, *args, &block)
  SmsR::Providers.load File.dirname(__FILE__) + 
                          "/../../lib/providers/#{cmd}.rb"
                          
  # rcov hack
  begin
    require File.dirname(__FILE__) + 
                            "/../../lib/providers/#{cmd}.rb"
  rescue NoMethodError => e
  end
  
  block.call
  SmsR::Providers.providers[cmd].call args
end
