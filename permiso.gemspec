# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "permiso/version"

Gem::Specification.new do |s|
  s.name        = "permiso"
  s.version     = Permiso::VERSION
  s.authors     = ["Piotr Zolnierek"]
  s.email       = ["pzolnierek@gmail.com"]
  s.homepage    = "https://github.com/pzol/permiso"
  s.summary     = %q{A lightweight gem for checking permissions}
  s.description = %q{see README.md}

  s.rubyforge_project = "permiso"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
