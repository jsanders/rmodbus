require 'rubygems'
spec = Gem::Specification.new do |s|
  s.name = "rmodbus"
  s.version = "0.1.2"
  s.authors = ['A.Timin', 'D.Samatov', 'J.Sanders']
  s.email = 'sanderjd@gmail.com'
  s.homepage = 'http://rubyforge.org/var/svn/rmodbus/trunk'
  s.platform = Gem::Platform::RUBY
  s.summary = "RModBus - free implementation of protocol ModBus"
  s.files = Dir['lib/**/*.rb', 'ext/*']
  s.has_rdoc = true
  s.extensions = ["ext/extconf.rb"]
  s.rdoc_options = ["--title", "RModBus", "--inline-source", "--main", "README"]
  s.extra_rdoc_files = ["README", "AUTHORS", "LICENSE", "CHANGES"]
end
