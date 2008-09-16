module SmsR  
module Providers
  
  DEFAULT_PROVIDERS_FILE = File.dirname(__FILE__) + 
                          '/../providers/default_providers'
  
  extend self
  
  def provider(provider_name, &block)
    SmsR.debug "registering #{provider_name}"
    providers[provider_name] = Provider.new(block)
  end

  def providers
    @providers ||= {}
  end
  
  def load(file=DEFAULT_PROVIDERS_FILE, drop_existing=false)
    if File.exists? file
      SmsR.debug "Loading providers from: #{file}"
      data = File.read(file)
      @providers = {} if drop_existing
      module_eval data, file
    else
      SmsR.debug "Provider file #{file} doesn't exist."
    end
    @providers
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
  
end
end
