module SmsR  
module Providers
  
  DEFAULT_PROVIDERS = File.dirname(__FILE__) + 
                          '/../providers'
  
  extend self
  
  def provider(provider_name, &block)
    SmsR.debug "registering #{provider_name}"
    providers[provider_name] = Provider.new(block)
  end

  def providers
    @providers ||= {}
  end
  
  def reset
    @providers = {}
  end
  
  def load(*files)
    files.each do |file|
      if File.exists? file
        SmsR.debug "Loading providers from: #{file}"
        data = File.read(file)
        # @providers = {} if drop_existing
        module_eval data, file
      else
        SmsR.info "Provider file #{file} doesn't exist."
      end
    end
    providers
  end
  
end

module ProviderHelper

  def find_form_with_field(page, fieldname)
    page.forms.each do |form|
      if form.fields.find{|f| f.name == fieldname}
        yield form
      end
    end
  end
  
  def to_ISO_8859_1(msg)
    require "iconv"
    Iconv.conv("ISO-8859-1", "UTF-8", message)
  end
  
end
end
