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

            if runner.check
              runner.send(:"run_#{args.size}", *args)
            else
              SmsR.info runner.error
            end
          end
        end
        super
      end
      
      def initialize_class
        self.class_eval do
          define_method(:initialize) do |provider|
            @provider = provider.to_sym if provider
            @error = false
          end
        end
      end
      
      def runnable(*reqs, &block)
        n_of_block_args = if block.arity > 0
          block.arity
        else
          0
        end
        
        define_method(:check) do
          ret_val = true
          reqs.inject(ret_val) do |succ, req|
            if succ
              succ, @error = RunnableAction.send(req.to_sym, @provider)
            end
            ret_val = succ
          end
          ret_val
        end
        
        define_method(:"run_#{n_of_block_args}") do |*params|
          SmsR.debug "defining #{self.class}.run method with params: ",
                     "  #{params.join(',')}"
          instance_exec(*params, &block) if block_given?
        end
        
        define_method(:error) do
          @error
        end
      end
      
      def config(provider_name)
        [!!SmsR.config[provider_name.to_sym], 
          ["No config for #{provider_name} found. Run:",
            "", "  smsr-config #{provider_name} username password",
            "", "to set up the config for the selected provider."]]
      end

      def provider(provider_name)
        [!!SmsR::Providers.providers[provider_name.to_sym], 
          ["Provider '#{provider_name}' not found."]]
      end
      
    end

  end

end
end
