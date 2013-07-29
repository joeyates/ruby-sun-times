require "./lib/sun_times"

Gem::Specification.new do |s|
  s.name = 'ruby-sun-times'
  s.summary = 'Module which calculates sunrise and sunset times'
  s.version = SunTimes::VERSION::STRING

  s.homepage = 'http://github.com/joeyates/ruby-sun-times'
  s.author = 'Joe Yates'
  s.email = 'joe.g.yates@gmail.com'

  s.files = ['README', 'COPYING', 'Rakefile'] + Dir.glob('{lib,test}/**/*.rb')
  s.require_paths = ['lib']

  s.has_rdoc = true
  s.rdoc_options += ['--quiet', '--title', 'Sun Times Calculator', '--main', 'README', '--inline-source']
  s.extra_rdoc_files = ['README', 'COPYING']

  s.test_file = 'test/test_all.rb'
end
