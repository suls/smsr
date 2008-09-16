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
            SmsR.debug "running #{self.name} .. (#run_#{args.size})"
            runner = self.new(args.first)
            runner.send(:"run_#{args.size}", *args) if runner.check
          end
        end
        super
      end
      
      def initialize_class
        self.class_eval do
          define_method(:initialize) do |*args|
            @provider_name = args
          end
        end
      end
      
      def runnable(*reqs, &block)
        n_of_block_args = if block.arity > 0
          block.arity
        else
          0
        end
        
        define_method(:check) do |*args|
          success = true
          reqs.each do |req|
            success = RunnableAction.send(req.to_sym) if success
          end
          success
        end
        
        define_method(:"run_#{n_of_block_args}") do |*params|
          SmsR.debug "defining #{self.class}.run method with params: ",
                     "  #{params.join(',')}"
          instance_exec(*params, &block) if block_given?
        end
      end
      
      def config(for_provider)
        !!SmsR.config[for_provider.to_sym]
      end

      def provider_itself
        {:exists? => !!SmsR::Providers.providers[@provider_name.to_sym],
          :error => ["Provider '#{@provider_name}' not found."],
          :provider => SmsR::Providers.providers[@provider_name.to_sym] }
      end
    end

  end

end
end
