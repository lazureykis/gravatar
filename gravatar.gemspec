# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gravatar/version"

Gem::Specification.new do |s|
  s.name        = "gravatar"
  s.version     = Gravatar::VERSION
  s.authors     = ["Pavel Lazureykis"]
  s.email       = ["lazureykis@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Interface to gravatar.com}
  s.description = %q{Interface to gravatar.com. Supports user images and profiles.}

  s.rubyforge_project = "gravatar"
  
  s.add_dependency('json')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
