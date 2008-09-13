$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rake'
require 'hoe'
require 'spec/rake/spectask'
require 'smsr/version'

Hoe.new('smsr', SmsR::VERSION::STRING) do |p|
  p.summary = SmsR::VERSION::SUMMARY
  p.url = 'http://sulsarts.ch/'
  p.description = "Simple commandline utility for sending sms."
  p.developer('Mathias Sulser', 'suls@suls.org')
end

['audit','test','test_deps','default','publish_docs','post_blog', 'post_news'].each do |task|
  Rake.application.instance_variable_get('@tasks').delete(task)
end

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end
