module SmsR
module Actions
  
  class RunnableAction
    attr_writer :provider_name
    class << self
    
      def inherited(child)
        child.instance_eval do 
          initialize_class
          def self.run(args)
            SmsR::Providers.load
            
            SmsR.debug "running #{self.name} .. (#run_#{args.size})"
            runner = self.new(args.first)
            runner.send :"run_#{args.size}", *args
          end
        end
        super
      end
      
      def initialize_class
        self.class_eval do
          define_method(:initialize) do |args|
            @provider_name = args
          end
        end
      end
      
      def runnable(*params, &block)
        n_of_block_args = if block.arity > 0
          block.arity
        else
          0
        end
        
        define_method(:"run_#{n_of_block_args}") do |*params|
          SmsR.debug "defining #{self.class}.run method with params: ",
                     "  #{params.join(',')}"
          instance_exec(*params, &block) if block_given?
          self
        end
      end
    end

    def provider_config
      {:exists? => !!SmsR.config[@provider_name],
        :error => ["No config for #{@provider_name} found. Run:",
                  "", "  smsr-config #{@provider_name} username password",
                  "", "to set up the config for the selected provider."] }
    end
    
    def provider_itself
      {:exists? => !!SmsR::Providers.providers[@provider_name.to_sym],
        :error => ["Provider '#{@provider_name}' not found."]}
    end
  end

end
end
