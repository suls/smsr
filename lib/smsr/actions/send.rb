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
      
      SmsR.debug "using #{provider_itself[:provider]} " +
                  "with config #{provider_config[:config]}"
      
      
      provider_itself[:provider].call provider_config[:config].user, 
                                      provider_config[:config].password,
                                      number, message      
      
    end
  end

end
end
