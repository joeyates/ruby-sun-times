# -*- encoding: utf-8 -*-
$LOAD_PATH << File.expand_path('lib', File.dirname(__FILE__))

require 'sun_times/version'

Gem::Specification.new do |spec|
  spec.name             = 'ruby-sun-times'
  spec.summary          = 'Calculate sunrise and sunset times for a given time and place'
  spec.version          = SunTimes::VERSION::STRING

  spec.homepage         = 'https://github.com/joeyates/ruby-sun-times'
  spec.author           = 'Joe Yates'
  spec.email            = 'joe.g.yates@gmail.com'

  spec.files            = `git ls-files -z`.split("\0")
  spec.executables      = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files       = spec.files.grep(%r{^spec/})
  spec.require_paths    = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
end
