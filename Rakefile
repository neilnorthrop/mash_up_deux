require 'rake/testtask'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['-f progress']
end

Rake::TestTask.new do |task|
  task.pattern = "test/**/*_test.rb"
end
