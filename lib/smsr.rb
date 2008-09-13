$:.unshift File.dirname(__FILE__)

require "smsr/version"
require "ostruct"
require "optparse"

module SmsR

  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/232636
  extend self
  
  def start(args, io=STDOUT)
    @io = io
    @options = parse_options(args)
    @debug = @options.debug
    debug "SmsR #{VERSION::STRING} started .."
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
    
    begin
      OptionParser.new do |opts|
        opts.banner = "Usage: smsr [options]"

        opts.on("-d", "--debug", "Show debug log statements") do |d|
          options.debug = d 
        end
        
        opts.on_tail("--version", "Show version") do
          @io.puts VERSION::STRING
          exit
        end
      end.parse!(args)
    rescue OptionParser::InvalidOption => e
      @io.puts e
      exit
    end
    
    options
  end
  
  def options
    @options
  end
  
end
