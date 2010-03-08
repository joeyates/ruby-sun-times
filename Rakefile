require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rake/clean'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'sun_times'

RDOC_OPTS = ['--quiet', '--title', 'Sun Times Calculator', '--main', 'README', '--inline-source']
CLEAN.include 'doc'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name = 'ruby-sun-times'
  s.summary = 'Module which calculates sunrise and sunset times'
  s.version = SunTimes::VERSION::STRING

  s.homepage = 'http://github.com/joeyates/ruby-sun-times'
  s.author = 'Joe Yates'
  s.email = 'joe.g.yates@gmail.com'

  s.files = ['README', 'COPYING', 'Rakefile'] + FileList['{lib,test}/**/*.rb']
  s.require_paths = ['lib']

  s.has_rdoc = true
  s.rdoc_options += RDOC_OPTS
  s.extra_rdoc_files = ['README', 'COPYING']

  s.test_file = 'test/test_all.rb'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.options += RDOC_OPTS
  rdoc.main = "README"
  rdoc.rdoc_files.add ['README', 'COPYING', 'lib/**/*.rb']
end

Rake::GemPackageTask.new(spec) do |pkg|
end
