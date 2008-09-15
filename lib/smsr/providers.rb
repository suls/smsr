require "smsr"

module SmsR
module Providers
  extend self
  
  def provider(*args, &block)
    # puts "registering #{args}"
    args.each do |method_name|
      define_method(method_name) do |*params|
        instance_exec(*params, &block) if block_given?
      end
    end
  end

  
end
end
