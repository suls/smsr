$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rake'
require 'hoe'
require 'spec/rake/spectask'
require 'smsr/version'

namespace :hoe do
Hoe.new('smsr', SmsR::VERSION::STRING) do |p|
  p.summary = SmsR::VERSION::SUMMARY
  p.url = 'http://sulsarts.ch/p/smsr'
  p.description = "Simple commandline utility for sending sms."
  p.developer('Mathias Sulser', 'suls@suls.org')
  p.extra_deps << ["mechanize", ">= 0.7.8"]
end

['audit','test','test_deps','default','publish_docs',
  'announce', 'post_blog', 'post_news'].
  map{ |tsk| 'hoe:'+tsk}.
  each do |task|
    Rake.application.instance_variable_get('@tasks').delete(task)
  end
end

namespace :spec do
  desc "Run all specs with rcov"
  Spec::Rake::SpecTask.new('rcov') do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.rcov = true
    t.rcov_opts << '--exclude' << 'spec,gems'
  end

  desc "Run all specs"
  Spec::Rake::SpecTask.new('run') do |t|
    t.spec_files = FileList['spec/**/*.rb']
  end
end
