gem 'ci_reporter'
require 'ci/reporter/rake/cucumber'
require 'ci/reporter/rake/rspec'
require 'rake'
require 'cucumber'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

require 'bundler/gem_tasks'

# setup rspec tests
RSpec::Core::RakeTask.new(:spec) do |t|
  Rake::Task['ci:setup:rspec'].invoke
  t.rspec_opts = ["--color"]
  t.rspec_opts = ["-r ./junit.rb -f JUnit -o spec/reports/results.xml"]
end

Cucumber::Rake::Task.new(:features) do |t|
  Rake::Task['ci:setup:cucumber_report_cleanup'].invoke
  ENV['CUCUMBER_OPTS'] = "#{ENV['CUCUMBER_OPTS']} -f CI::Reporter::Cucumber"
  t.cucumber_opts = "-f junit --out features/reports/ -f pretty"
end

# setup RCov code coverage test
namespace :spec do
  RSpec::Core::RakeTask.new('rcov') do |t|
    t.pattern = 'spec/**/*.rb'
    t.rcov = true
  end
end

task :test => :spec
task :test => :features
