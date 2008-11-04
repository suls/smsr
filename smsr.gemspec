# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smsr}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mathias Sulser"]
  s.date = %q{2008-11-04}
  s.description = %q{Simple commandline utility for sending sms.}
  s.email = ["suls@suls.org"]
  s.executables = ["smsr", "smsr-config", "smsr-send"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = [".autotest", ".gitignore", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/smsr", "bin/smsr-config", "bin/smsr-send", "lib/providers/hispeed.rb", "lib/providers/o2.rb", "lib/providers/orange.rb", "lib/providers/swisscom.rb", "lib/smsr.rb", "lib/smsr/actions.rb", "lib/smsr/actions/config.rb", "lib/smsr/actions/list.rb", "lib/smsr/actions/send.rb", "lib/smsr/config.rb", "lib/smsr/extensions.rb", "lib/smsr/providers.rb", "lib/smsr/providers/provider.rb", "lib/smsr/smsr.rb", "lib/smsr/version.rb", "smsr.gemspec", "spec/providers/hispeed_spec.rb", "spec/providers/orange_spec.rb", "spec/providers/provider_helper.rb", "spec/providers/swisscom_spec.rb", "spec/smsr/actions/config_spec.rb", "spec/smsr/actions/send_spec.rb", "spec/smsr/actions_requirements_spec.rb", "spec/smsr/actions_spec.rb", "spec/smsr/config_spec.rb", "spec/smsr/providers_spec.rb", "spec/smsr/version_spec.rb", "spec/smsr_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://sulsarts.ch/p/smsr}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{smsr}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{SmsR version 0.0.1}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, [">= 0.7.8"])
      s.add_runtime_dependency(%q<rspec>, [">= 1.1.4"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<mechanize>, [">= 0.7.8"])
      s.add_dependency(%q<rspec>, [">= 1.1.4"])
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<mechanize>, [">= 0.7.8"])
    s.add_dependency(%q<rspec>, [">= 1.1.4"])
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
