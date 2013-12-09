# do test coverage for rspec tests and put results in coverage/rspec
if RUBY_VERSION > "1.9"
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.start do
    SimpleCov.coverage_dir 'coverage'
    SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  end
end
require 'bak'
