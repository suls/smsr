$:.unshift File.dirname(__FILE__)

module SmsR
  VERSION = '0.1.0'
  
  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/232636
  extend self
  
  def start(args)
    # @options = parse_options(args)
    @options = {}
    @debug = @options[:debug] = true
    debug "SmsR #{VERSION} started .."
  end
  
  def debug(*messages)
    puts messages.map { |m| "** #{m}" } if debug?
  end

  def debug?
    !!@debug
  end
  
  
end