# setup test coverage checks for cucumber tests and put results in coverage/cucumber
if RUBY_VERSION > "1.9"
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
  SimpleCov.coverage_dir 'coverage'
end

$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'bak'
require 'open3'
