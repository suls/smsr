module SmsR
module Actions
  module RunnableAction

    def self.included(dest_module)
      super

      def dest_module.run(args)
        puts "running #{self.name} .."
        self.module_eval do
          runner = self.new(args)
          runner.run
        end
      end
    end 
    
    def initialize(*args)
      @args = args
    end
    
    def run
      puts @args
    end  
  end
  
  class Config
    include RunnableAction
  end
  
  class Send
    include RunnableAction
  end
end
end
