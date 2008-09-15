= SmsR

* http://sulsarts.ch/p/smsr

== DESCRIPTION:

SmsR is a simple command line SMS sender utility.

== FEATURES/PROBLEMS:

* lots

== SYNOPSIS:

Add a new provider like this:

  desc "my sample operator"
  provider :sample_operator do |user, password, number, text|
    # login on the website and send SMS
  end

Setup the provider by providing username and password:

  smsr-config sample_operator my_username my_password
  
Your provider is now available:

  smsr-send sample_operator +41XXXXXXXXX "this is your text message"

== INSTALL:

  [sudo] gem install rspec
  
or
  
  git clone git://github.com/suls/smsr.git
  cd smsr
  rake gem
  rake install_gem
  
== ACKNOWLEDGEMENTS:

Thanks to Mirko Stocker for the idea (http://blog.misto.ch/archives/606) and
to Gui for the Swisscom provider
(http://giu.me/01-09-2008-sms-senden-leicht-gemacht-swisscom.html).

== LICENSE:

(The MIT License)

Copyright (c) 2008 Mathias Sulser

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
