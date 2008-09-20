module SmsR
module Actions

  class List < RunnableAction
    runnable :load_providers do
      
      SmsR.info "","Available providers:", ""
      SmsR::Providers.providers.each do |name, prov|
        if SmsR.config[name.to_sym]
          has_config = ""
        else 
          has_config = "*"
        end
        SmsR.info "\t#{name} #{has_config}"
      end
      SmsR.info "","* indicates no config saved for the provider."
    end
  end
  
end
end
