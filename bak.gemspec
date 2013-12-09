Gem::Specification.new do |s|
  s.name        = 'bak'
  s.version     = '0.0.0'
  s.date        = '2013-12-09'
  s.summary     = "small utility for creating named backup files and directories"
  s.description = "quickly create backup files and directories with extensions, prefixes, replacements, and other patterns"
  s.authors     = ["Alex Freidah"]
  s.email       = 'alex.freidah@gmail.com'
  s.files       = ["lib/bak.rb", "lib/bak/copier.rb", "lib/bak/backup_name_generator.rb"]
  s.homepage    = 'http://bak.com'
  s.license       = 'MIT'
  s.executables = ["bak"]
  s.require_paths = ["lib", "lib/bak"]
end
