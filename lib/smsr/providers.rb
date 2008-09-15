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
  
  def load(file, drop_existing=false)
    if File.exists? file
      SmsR.debug "Loading providers from: #{file}"
      data = File.read(file)
      @providers = {} if drop_existing
      module_eval data, file
    else
      SmsR.debug "Provider file #{file} doesn't exist."
    end
  end
  
  class Provider
    def initialize(block)
      add_instance_method :call, block
    end
  end
end
end
