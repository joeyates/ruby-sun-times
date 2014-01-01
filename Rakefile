require 'rubygems'
require 'rake/testtask'
require 'rake/clean'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'sun_times'

CLEAN.include 'doc'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
