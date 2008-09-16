require "rubygems"
require "mechanize"

# from Gui
# http://giu.me/01-09-2008-sms-senden-leicht-gemacht-swisscom.html
provider :swisscom do |user, password, number, message|
  SmsR.debug "args: ", user, password, number, message
  WWW::Mechanize.new do |agent|
    SmsR.debug "logging in .."
    agent.get('https://www.swisscom-mobile.ch/selfreg/SelfRegistration?'+
              'uri=/youth/youth_zone_home-de.aspx') do |page|

      find_form_with_field(page, 'isiwebuserid') do |f|
        f.isiwebuserid = username
        f.isiwebpasswd = password
        f.submit
      end
    end
    SmsR.debug ".. done"
    

    agent.get('https://www.swisscom-mobile.ch'+
              '/youth/sms_senden-de.aspx') do |page|
      SmsR.debug "start sending .."
      find_form_with_field(page, 'CobYouthSMSSenden:txtMessage') do |f|
        f['CobYouthSMSSenden:txtNewReceiver']= number
        f['CobYouthSMSSenden:txtMessage']= message
        submit_button= nil
        #finde den richtigen submit-button
        f.buttons.each do |button|
          if button.name = 'CobYouthSMSSenden:btnSend' then 
            submit_button= button
            break
          end
        end
        f.submit(submit_button)
      end 
    end
    SmsR.debug ".. done"
  end
end
