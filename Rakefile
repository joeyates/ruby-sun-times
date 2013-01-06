require "bundler/gem_tasks"
require 'rdoc/task'
require 'rake/testtask'
require 'rake/clean'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'sun-times'

RDOC_OPTS = ['--quiet', '--title', 'Sun Times Calculator', '--main', 'README.md', '--inline-source']
CLEAN.include 'doc'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.options += RDOC_OPTS
  rdoc.main = "README.md"
  rdoc.rdoc_files.add ['README.md', 'COPYING', 'lib/**/*.rb']
end
