require "rubygems"
require "mechanize"

provider :o2 do |user, password, number, message|
  SmsR.debug "args: ", user, password, number, message

end
