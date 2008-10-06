require "rubygems"
require "rake"

module SmsR
module Actions
  
    class Send < RunnableAction
    runnable :load_providers do 
      SmsR.info "Available providers:"
      SmsR::Providers.providers.each { |k,v| SmsR.info "  #{k}"}
    end
    
    runnable :load_providers, :config, :provider do |provider_name, number, message|
        
      SmsR.debug "using #{@provider} " +
                              "with config #{@config}"
      
      @provider.call @config.user, @config.password, number, message      
      
    end
  end

end
end
