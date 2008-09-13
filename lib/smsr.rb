$:.unshift File.dirname(__FILE__)

require "smsr/version"
require "ostruct"
require "optparse"

module SmsR

  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/232636
  extend self
  
  def start(args, io=STDOUT)
    @options = parse_options(args)
    @io = io
    @debug = @options.debug
    debug "SmsR #{VERSION} started .."
  end
  
  def debug(*messages)
    @io.puts messages.map { |m| "** #{m}" } if debug?
  end

  def debug?
    !!@debug
  end
  
  def parse_options(args)
    options = OpenStruct.new
    options.debug = false
    
    OptionParser.new do |opts|
      opts.banner = "Usage: smsr [options]"

      opts.on("-d", "--debug", "Show debug log statements") do |d|
        options.debug = d 
      end
    end.parse!(args)
    
    options
  end
  
  def options
    @options
  end
  
end
