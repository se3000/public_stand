# -*- encoding: utf-8 -*-
# stub: better_receive 0.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "better_receive"
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Steve Ellis", "Matthew Horan"]
  s.date = "2013-10-30"
  s.description = "Assert that an object responds to a method before asserting that the method is received."
  s.email = ["email@steveell.is", "matt@matthoran.com"]
  s.homepage = "http://github.com/se3000/better_receive"
  s.rubygems_version = "2.2.0"
  s.summary = "A more assertive mock."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, ["~> 2.14"])
      s.add_runtime_dependency(%q<rspec-core>, ["~> 2.14.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<rspec-core>, ["~> 2.14.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<rspec-core>, ["~> 2.14.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
