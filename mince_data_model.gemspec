# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mince_data_model/version"

Gem::Specification.new do |s|
  s.name        = "mince_data_model"
  s.version     = MinceDataModel::VERSION
  s.authors     = ["Jason & Matt (Asynchrony)"]
  s.email       = ["dev@asolutions.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "mince_data_model"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_dependency("rails", "~> 3.0")
end
