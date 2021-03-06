require "ostruct"
require "optparse"

module SmsR

  extend self
  
  def start(args, io=STDOUT)
    @io = io
    args_copy = args.dup
    @options = parse_options(args)
    
    info ""
    debug "args: ", args_copy << " "
    debug "options: ", options
    
    debug "SmsR #{VERSION::STRING} started .."
    
    invoke_action(args.shift, args) if args.size > 0 if args
    
    debug ".. exiting SmsR"
    info ""
  end
  
  def debug?
    !!@debug
  end
  
  # FIXME: duplication!
  def debug(*messages)
    @io.puts messages.map { |m| "** #{m}" } if debug?
  end
  
  # FIXME: duplication!
  def info(*messages)
    @io.puts messages.map { |m| " #{m}" }
  end
  
  def parse_options(args)
    options = OpenStruct.new
    options.debug = false
    
    begin
      OptionParser.new do |opts|
        opts.banner = <<BANNER
Usage: smsr [action] [parameters] [options]

  To send a sms:
  
    $ smsr-send provider_name 079xx "this is my message"
  
  Provider 'provider_name' must exist. To see what providers exist:
  
    $ smsr list
  
BANNER

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
    
    @debug = options.debug
    
    options
  end
  
  def options
    @options
  end
  
  def config
    @config ||= Config.load 
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
