module SmsR
  OperatorConfig = Struct.new(:user, :password)
  
  class Config
    
    def self.load(file=ENV['HOME']+'/.smsr_config')
      return File.open(file) { |f| YAML.load(f) } if File.exists? file
      Config.new(file)
    end
    
    def save!(f_to_save=@config_file)
      File.open(f_to_save, "w") { |f| YAML.dump(self, f) }
    end
    
    def initialize(f)
      @config_file = f
      @config = {}
    end
    
  end
end
