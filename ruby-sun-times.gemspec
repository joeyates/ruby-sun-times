# -*- encoding: utf-8 -*-
$:.unshift(File.expand_path('../lib/', __FILE__))

require 'rake'
require 'sun_times/version'

Gem::Specification.new do |s|
  s.name = 'ruby-sun-times'
  s.summary = 'Module which calculates sunrise and sunset times'
  s.version = SunTimes::VERSION::STRING

  s.homepage = 'http://github.com/joeyates/ruby-sun-times'
  s.author = 'Joe Yates'
  s.email = 'joe.g.yates@gmail.com'

  s.files = ['README', 'COPYING', 'Rakefile'] + Rake::FileList['{lib,test}/**/*.rb']
  s.require_paths = ['lib']

  s.extra_rdoc_files = ['README', 'COPYING']

  s.test_file = 'test/test_all.rb'
end
