module SmsR
module Actions
  
    class Send < RunnableAction
    runnable do 
      SmsR.info "TODO: list available providers"
    end
    
    runnable do |provider, number, message|
      SmsR.info "TODO: implement sending"
    end
  end

end
end
