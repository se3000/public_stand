# -*- encoding: utf-8 -*-
# stub: elementaljs-rails 0.0.11 ruby lib vendor

Gem::Specification.new do |s|
  s.name = "elementaljs-rails"
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib", "vendor"]
  s.authors = ["Robbie Clutton"]
  s.date = "2013-11-02"
  s.description = "A Gem wrapper for ElementalJS"
  s.email = ["robert.clutton@gmail.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "A Gem wrapper for ElementalJS"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
