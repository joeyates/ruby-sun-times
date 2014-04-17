# -*- encoding: utf-8 -*-
$LOAD_PATH << File.expand_path('lib', File.dirname(__FILE__))

require 'sun_times/version'

Gem::Specification.new do |s|
  s.name             = 'ruby-sun-times'
  s.summary          = 'Module which calculates sunrise and sunset times'
  s.version          = SunTimes::VERSION::STRING

  s.homepage         = 'https://github.com/joeyates/ruby-sun-times'
  s.author           = 'Joe Yates'
  s.email            = 'joe.g.yates@gmail.com'

  s.files            = `git ls-files`.split($\)
  s.executables      = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files       = s.files.grep(%r{^spec/})
  s.require_paths    = ['lib']

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
end
