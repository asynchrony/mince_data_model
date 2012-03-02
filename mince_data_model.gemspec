# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mince_data_model/version"

Gem::Specification.new do |s|
  s.name        = "mince_data_model"
  s.version     = MinceDataModel::VERSION
  s.authors     = ["Jason Mayer", "Matt Simpson", "Asynchrony Solutions"]
  s.email       = ["matt@railsgrammer.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/asynchrony/mince_data_model"
  s.summary     = %q{Interface for interchanging which type of data store to persist data to}
  s.description = %q{Interface for interchanging which type of data store to persist data to}

  s.rubyforge_project = "mince_data_model"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_dependency("rails", "~> 3.0")
end
