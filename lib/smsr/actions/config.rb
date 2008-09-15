module SmsR
module Actions

  class Config < RunnableAction
    runnable do |provider, user, password|
      SmsR.debug "Store entry for #{provider}"
      SmsR.config[:"#{provider}"] = user, password
      SmsR.config.save!
      SmsR.info "#{provider} added to config"
    end

    runnable do |provider|
      p_c = SmsR.config[:"#{provider}"]
      SmsR.info "#{provider} :"
      %w{user password}.each { |e|  SmsR.info "  #{e}: #{p_c.send e}"}
    end    
  
  end
  
end
end
