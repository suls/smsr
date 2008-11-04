$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rake'
require 'hoe'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'
require 'smsr/version'


desc "Clean up everything"
task :clean => ["spec:clobber_rcov", "hoe:clean"] do
end

namespace :hoe do
$hoe = Hoe.new('smsr', SmsR::VERSION::STRING) do |p|
  p.summary = SmsR::VERSION::SUMMARY
  p.url = 'http://sulsarts.ch/p/smsr'
  p.description = "Simple commandline utility for sending sms."
  p.developer('Mathias Sulser', 'suls@suls.org')
  p.extra_deps << ["mechanize", ">= 0.7.8"] << ["rspec", ">= 1.1.4"]
  p.changes = p.paragraphs_of("History.txt", 0..1).join("\n\n")
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
    t.spec_files = FileList['spec/**/*_spec.rb']

    t.rcov = true
    t.rcov_opts << 
      '--exclude' << 
      'spec,gems' << 
      "--text-report"
  end
  
  desc "Check spec coverage"
  RCov::VerifyTask.new(:coverage => "spec:rcov") do |t|
    t.threshold = 90.0 # Make sure you have rcov 0.7 or higher!
    t.index_html = File.dirname(__FILE__) + '/coverage/index.html'
    
    system "open coverage/index.html" if RUBY_PLATFORM =~ /darwin/
  end

  desc "Run all specs"
  Spec::Rake::SpecTask.new('run') do |t|
    t.spec_files = FileList['spec/**/*.rb']
  end
end

namespace :gemspec do
  desc 'Refresh smsr.gemspec to include ALL files'
  task :refresh => 'manifest:refresh' do
    File.open('smsr.gemspec', 'w') {|io| io.write($hoe.spec.to_ruby)}
  end
end

namespace :manifest do
  desc 'Recreate Manifest.txt to include ALL files'
  task :refresh do
    `rake hoe:check_manifest | patch -p0 > Manifest.txt`
  end
end
