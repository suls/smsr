module SmsR
module Actions
  
  class RunnableAction
    class << self
    
      def inherited(child)
        child.instance_eval do 
          # initialize_class
          def self.run(args)
            SmsR.debug "running #{self.name} .. (#{args.size})"
            runner = self.new
            runner.run(*args)
          end
        end
        super
      end
      
      def runnable(*params, &block)
        define_method(:run) do |*params|
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
      SmsR.debug provider, user, password
    end

    # runnable do |provider|
    #   SmsR.debug provider
    # end    
    
  end
  
  class Send < RunnableAction
    runnable do |provider, number, text|
      SmsR.debug provider, number, text
    end
  end
end
end
