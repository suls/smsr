module SmsR
module Actions
  
  class RunnableAction
    attr_writer :provider_name
    class << self
    
      def inherited(child)
        child.instance_eval do 
          initialize_class
          def self.run(*args)
            SmsR::Providers.load
            args.flatten!
            SmsR.debug "running #{self.name} .. (#run_#{args.size})",
                        "with args: #{args.join(',')}"
            runner = self.new(args.first)
            
            SmsR.info runner.error unless runner.
                                            send(:"run_#{args.size}", *args)
          end
        end
        super
      end
      
      def initialize_class

        self.class_eval do
          include SmsR::Actions.requirements
          attr_reader :error
          attr_accessor :requirements
          define_method(:initialize) do |provider|
            @provider_name = provider.to_sym if provider
            @error = []
            @requirements = []
          end
        end
      end
      
      def runnable(*reqs, &block)
        n_of_block_args = if block.arity > 0
          block.arity
        else
          0
        end
        
        define_method(:"run_#{n_of_block_args}") do |*params|
          self.requirements = reqs
          
          SmsR.debug "defining #{self.class}.run method with params: ",
                     "  #{params.join(',')}"
          if check
            instance_exec(*params, &block) if block_given?
            return true
          end
          false
        end
        
        define_method(:check) do
          requirements.inject(true) do |succ, req|
            succ = self.send req.to_sym if succ
            succ
          end
        end
        
      end

    end

  end
  
  module Requirements
    
    def config
      @config = SmsR.config[@provider_name]
      unless !!@config
        @error << ["No config for #{provider_name} found. Run:",
                  "", "  smsr-config #{provider_name} username password",
                  "", "to set up the config for the selected provider."]
      end
      !!@config
    end

    def provider
      @provider = SmsR::Providers.providers[@provider_name] 
      unless !!@config
        @error << ["Provider '#{provider_name}' not found."]
      end
      !!@provider
    end
  end
  # module requirements
  # included in Concr.Action
  
  def self.requirements
    Requirements
  end
end
end
