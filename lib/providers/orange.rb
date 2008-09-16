require "rubygems"
require "mechanize"

# from Mirko
# http://blog.misto.ch/archives/606
provider :orange do |user, password, number, message|
  SmsR.debug "args: ", user, password, number, message
  
  WWW::Mechanize.new do |agent|
    SmsR.debug "logging in .."
    agent.get('https://www.orange.ch/footer/login') do |page|
      find_form_with_field(page, 'username') do |f|
        f.username = user
        f.password = password
        f.submit
      end
    end
    SmsR.debug ".. done"

    agent.get('https://www.orange.ch/myorange/sms') do |page|
      SmsR.debug "start sending .."
      find_form_with_field(page, 'messageInput') do |f|
        f.destinationNumberInput = number
        f.messageInput = to_ISO_8859_1(message)
        f.wui_target_id = 'sendButton'
        f.wui_event_id = 'onclick'
        f.submit
      end
      SmsR.debug ".. done"
    end
    
    SmsR.info "SMS '#{message}' sent to #{number}"
  end
end
