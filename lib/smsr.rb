$:.unshift File.dirname(__FILE__)

require "smsr/extensions"
require "smsr/version"
require "smsr/config"
require "smsr/actions"
require "ostruct"
require "optparse"

module SmsR
  
  # include Actions
  
  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/232636
  extend self
  
  def start(args, io=STDOUT)
    @io = io
    args_copy = args.dup
    @options = parse_options(args)
    
    debug "args: ", args_copy << " "
    debug "options: ", options
    
    debug "SmsR #{VERSION::STRING} started .."
    
    invoke_action(args.shift, args) if args.size > 0 if args
    debug ".. exiting SmsR"
  end
  
  def debug(*messages)
    @io.puts messages.map { |m| "** #{m}" } if @options.debug
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
  
  def invoke_action(action, args)
    action = action.capitalize
    available_actions = (Actions.constants - ['RunnableAction'])
    debug "available actions: ", *(available_actions.map{|e| "\t"+e}) << " "
    
    if available_actions.include?(action)
      Actions.const_get(action).run(args)
    else
      debug "selected action not available: #{action}"
    end
  end
  
end
