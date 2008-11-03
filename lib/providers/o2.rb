require "rubygems"
require "mechanize"

provider :o2 do |user, password, number, message|
  SmsR.debug "args: ", user, password, number, message
  WWW::Mechanize.new do |agent|
    SmsR.debug "logging in .."
    site = "http://www.o2.co.uk/login?dest=http://sendtxt.o2.co.uk/sendtxt/action/compose"
    agent.get(site) do |page|
      form = page.form("o2portal_sign_in_form")
      form["USERNAME"] = user
      form["PASSWORD"] = password
      form.submit
    end
    SmsR.debug ".. done"
    
    agent.get("http://sendtxt.o2.co.uk/sendtxt/action/compose") do |page|
      
      form =  page.form("sendtxtform")
      form["compose.to"] = number
      form["compose.message"] = message
      # pp form.buttons[-2]
      form.click_button form.buttons[-2]
      SmsR.debug "start sending .."
    end
    SmsR.debug ".. done"
  end
end
