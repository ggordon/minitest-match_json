require 'bundler/gem_tasks'
require 'rake/testtask'

namespace :coverage do
  desc 'Delete previous coverage results'
  task :clean do
    rm_rf 'coverage'
  end
end

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs.push 'test'
end
task test: 'coverage:clean'
task default: :test
