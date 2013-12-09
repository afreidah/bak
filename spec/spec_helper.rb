<<<<<<< HEAD

require 'simplecov'
SimpleCov.start do
    SimpleCov.coverage_dir('coverage/rspec')
end

=======
# do test coverage for rspec tests and put results in coverage/rspec
if RUBY_VERSION > "1.9"
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
  SimpleCov.coverage_dir 'coverage'
end
>>>>>>> master
require 'bak'
