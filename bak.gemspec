$:.unshift File.expand_path("../lib", __FILE__)
require 'bak/version'

Gem::Specification.new do |s|
  s.name        = 'bak'
  s.version     = Bak::VERSION
  s.date        = '2013-12-09'
  s.summary     = "small utility for creating named backup files and directories"
  s.description = "quickly create backup files and directories with extensions, prefixes, replacements, and other patterns"
  s.authors     = ["Alex Freidah"]
  s.email       = 'alex.freidah@gmail.com'
  s.files       = ["lib/bak.rb", "lib/bak/copier.rb", "lib/bak/backup_name_generator.rb", "lib/bak/version.rb"]
  s.homepage    = 'http://bak.com'
  s.license       = 'MIT'
  s.executables = ["bak"]
  s.require_paths = ["lib", "lib/bak"]
end
