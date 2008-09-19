module SmsR
module Actions

  class Config < RunnableAction
    runnable do |provider, user, password|
      SmsR.debug "Store entry for #{provider}"
      SmsR.config[:"#{provider}"] = user, password
      SmsR.config.save!
      SmsR.info "Config for #{provider} added."
    end

    runnable :config do |provider|
      p_c = SmsR.config[:"#{provider}"]
      SmsR.info "Saved config for Provider '#{provider}':"
      %w{user password}.each { |e|  SmsR.info "  #{e}: #{p_c.send e}"}
    end    
  
  end
  
end
end
