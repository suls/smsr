module SmsR  
module Providers
  extend self
  
  def provider(provider_name, &block)
    SmsR.debug "registering #{provider_name}"
    providers[provider_name] = Provider.new(block)
  end

  def providers
    @providers ||= {}
  end
  
  class Provider
    def initialize(block)
      add_instance_method :call, block
    end
  end
end
end
