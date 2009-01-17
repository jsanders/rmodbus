# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rmodbus}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aleksey Timin", "D.Samatov", "James Sanders"]
  s.date = %q{2009-01-16}
  s.description = %q{A free Ruby implementation of the ModBus protocol}
  s.email = %q{sanderjd@gmail.com}
  s.files = ["VERSION.yml", "AUTHORS", "CHANGES", "LICENSE", "README", "Rakefile", "lib/rmodbus", "lib/rmodbus/client.rb", "lib/rmodbus/exceptions.rb", "lib/rmodbus/tcp_client.rb", "lib/rmodbus/tcp_server.rb", "lib/rmodbus.rb", "spec/client_spec.rb", "spec/ext_spec.rb", "spec/rtu_client_spec.rb", "spec/tcp_client_spec.rb", "spec/tcp_server_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rubyforge.org/var/svn/rmodbus/trunk}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{RModBus - free implementation of protocol ModBus}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
