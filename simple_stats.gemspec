# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_stats/version"

Gem::Specification.new do |s|
  s.name        = "simple_stats"
  s.version     = SimpleStats::VERSION
  s.authors     = ["Brian Hempel"]
  s.email       = ["plasticchicken@gmail.com"]
  s.homepage    = "https://github.com/brianhempel/simple_stats"
  s.summary     = "Simple mean, median, modes, sum, and frequencies for Ruby arrays and enumerables. Tested and sensible."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
