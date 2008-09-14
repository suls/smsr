module SmsR
module Actions
  
  class RunnableAction
    class << self
    
      def inherited(child)
        child.instance_eval do 
          # initialize_class
          def self.run(args)
            SmsR.debug "running #{self.name} .. (#run_#{args.size})"
            runner = self.new
            runner.send :"run_#{args.size}", *args
          end
        end
        super
      end
      
      def runnable(*params, &block)
        n_of_block_args = if block.arity > 0
          block.arity
        else
          0
        end
        
        define_method(:"run_#{n_of_block_args}") do |*params|
          SmsR.debug "defining #{self.class}.run method with params: " +
                     "#{params.join(',')}"
          instance_exec(*params, &block) if block_given?
          self
        end
      end
    end
  end
  
  class Config < RunnableAction
    runnable do |provider, user, password|
      SmsR.debug "Store entry for #{provider}"
      SmsR.config[:"#{provider}"] = user, password
      SmsR.config.save!
      SmsR.info "#{provider} added to config"
    end

    runnable do |provider|
      p_c = SmsR.config[:"#{provider}"]
      SmsR.info "#{provider} :"
      %w{user password}.each { |e|  SmsR.info "  #{e}: #{p_c.send e}"}
    end    
    
  end
  
  class Send < RunnableAction
    runnable do 
      SmsR.info "TODO: list available providers"
    end
    
    runnable do |provider, number, message|
      SmsR.info "TODO: implement sending"
    end
  end
end
end
