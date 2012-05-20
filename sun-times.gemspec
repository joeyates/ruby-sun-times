$:.unshift(File.dirname(__FILE__) + '/lib')
require "sun_times"

Gem::Specification.new do |s|
  s.name = 'sun-times'
  s.summary = 'Module which calculates sunrise and sunset times'
  s.version = SunTimes::VERSION::STRING

  s.homepage = 'http://github.com/timoschilling/sun-times'
  s.author = ['Joe Yates', 'Timo Schilling']
  s.email = ['joe.g.yates@gmail.com', 'timo@schilling.io']

  s.files = ['README', 'COPYING', 'Rakefile'] + Dir['{lib,test}/**/*.rb']
  s.require_paths = ['lib']

  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'COPYING']

  s.test_file = 'test/test_all.rb'
end
