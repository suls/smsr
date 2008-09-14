module SmsR
module Actions
  
  class RunnableAction
    class << self
    
      def inherited(child)
        child.instance_eval do 
          initialize_class
          def self.run(args)
            SmsR.debug "running #{self.name} .."
            runner = self.new(args)
            runner.run *args
          end
        end
        super
      end
      
      def initialize_class
        self.class_eval do
          define_method(:initialize) do |args|
            @args = args
          end
        end
      end
      
      def runnable(*params, &block)
        SmsR.debug "defining run method with params: #{params}"
        define_method(:run) do |*params|
          instance_exec(*params, &block) if block_given?
          self
        end
      end
    end
  end
  
  class Config < RunnableAction
  end
  
  class Send < RunnableAction
  end
end
end
