module SmsR  
module Providers
  
  class Provider
    
    include ProviderHelper
    
    def initialize(block)
      add_instance_method :call, block
    end
  end
  
end
end