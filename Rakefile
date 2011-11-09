#!/usr/bin/env ruby

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

desc "run tests in turn"
task :turn do
  sh "turn -Ilib test/"
end

task :default => [:test]
