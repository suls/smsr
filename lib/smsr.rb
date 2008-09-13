$:.unshift File.dirname(__FILE__)
require "smsr/version"

module SmsR

  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/232636
  extend self
  
  def start(args)
    @options = parse_options(args)
    @debug = @options[:debug]
    debug "SmsR #{VERSION} started .."
  end
  
  def debug(*messages)
    puts messages.map { |m| "** #{m}" } if debug?
  end

  def debug?
    !!@debug
  end
  
  def parse_options(options)
    {}
  end
  
  def options
    @options
  end
  
end
