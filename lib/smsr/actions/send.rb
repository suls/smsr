module SmsR
module Actions
  
    class Send < RunnableAction
    runnable do 
      SmsR::Providers.load
      
      SmsR.info "Available providers:"
      SmsR::Providers.providers.each { |k,v| SmsR.info "  #{k}"}
    end
    
    runnable do |provider_name, number, message|
      SmsR::Providers.load
      
      unless provider_itself[:exists?]
        SmsR.info provider_itself[:error]
        return
      end

      unless provider_config[:exists?]
        SmsR.info(*provider_config[:error])
        return
      end
      
      SmsR.debug "using #{provider} with config #{provider_config}"
      
      
      provider.call number, message
      SmsR.info "TODO: implement sending"
      
      
    end
  end

end
end
