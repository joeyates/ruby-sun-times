# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sun-times/version'

Gem::Specification.new do |gem|
  gem.name          = "sun-times"
  gem.version       = SunTimes::VERSION
  gem.authors       = ["Timo Schilling", "Joe Yates"]
  gem.email         = ["timo@schilling.io", "joe.g.yates@gmail.com"]
  gem.description   = %q{Module which calculates sunrise and sunset times.}
  gem.summary       = %q{Module which calculates sunrise and sunset times.}
  gem.homepage      = "http://github.com/timoschilling/sun-times"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}){ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
end
