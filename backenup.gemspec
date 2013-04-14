

Gem::Specification.new do |s|
  s.name        = 'backenup'
  s.version     = '0.0.6'
  s.date        = '2013-04-11'
  s.summary     = "File backups via Git"
  s.description = "File backups via Git"
  s.authors     = ["Brian Lauber"]
  s.email       = 'constructible.truth@gmail.com'
  s.files       = ["lib/backenup.rb"]
  s.homepage    = 'https://briandamaged.org/'
  
  s.add_dependency "grit", ">= 2.5.0"
end

