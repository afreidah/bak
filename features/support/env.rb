require 'simplecov'
SimpleCov.start do
    SimpleCov.coverage_dir('coverage/cucumber')
end

$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'bak'
require 'open3'
