gem 'ci_reporter'
require 'ci/reporter/rake/cucumber'
require 'ci/reporter/rake/rspec'
require 'rake'
require 'cucumber'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

# setup rspec tests
RSpec::Core::RakeTask.new(:spec) do |t|
  Rake::Task['ci:setup:rspec'].invoke
  t.rspec_opts = ["--color"]
end

Cucumber::Rake::Task.new(:features) do
  Rake::Task['ci:setup:cucumber_report_cleanup'].invoke
  ENV['CUCUMBER_OPTS'] = "#{ENV['CUCUMBER_OPTS']} -f CI::Reporter::Cucumber"
end

# setup RCov code coverage test
namespace :spec do
  RSpec::Core::RakeTask.new('rcov') do |t|
    t.pattern = 'spec/**/*.rb'
    t.rcov = true
  end
end
