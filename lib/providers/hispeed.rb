require "rubygems"
require "mechanize"

provider :hispeed do |user, password, number, message|
  SmsR.debug "args: ", user, password, number, message
  
  WWW::Mechanize.new do |agent|
    SmsR.debug "logging in .."
    agent.get('https://your.hispeed.ch/') do |page|
      find_form_with_field(page, 'mail') do |f|
        f.mail = user
        f.password = password
        f.submit
      end
    end
    SmsR.debug ".. done"

    agent.get('https://your.hispeed.ch/de/apps/messenger/') do |page|
      SmsR.debug "start sending .."

      iframe = page.iframes.text('external_application')
      agent.get(iframe.src) do |inner_page|
        form = inner_page.form('smsBean')
        form.recipient = number
        form.checkboxes.name('recipientChecked').check
        form.message = message
        form.submit
      end

      SmsR.debug ".. done"
    end

    SmsR.info "SMS '#{message}' sent to #{number}"
  end
end
