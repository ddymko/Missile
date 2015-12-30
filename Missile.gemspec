# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Missile/version'

Gem::Specification.new do |spec|
  spec.name          = "Missile-Deploy"
  spec.version       = Missile::VERSION
  spec.authors       = ["ddymko"]
  spec.email         = ["dymkod@gmail.com"]

  spec.summary       = %q{CLI tool that allows you to do deployments}
  spec.description   = %q{Missile allows you to easily and quickly define what project you want to deployed to a specific location}
  spec.homepage      = "http://ddymko.github.io/Missile"
  spec.license       = "MIT"



  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'net-scp'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
