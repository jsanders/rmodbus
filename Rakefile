begin
  require 'rubygems'
rescue Exception
end

begin
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['-c']
    t.libs << 'lib'
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true 
  end
rescue Exception 
  puts 'RSpec not available. Install it with: sudo gem install rspec'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "rmodbus"
    s.summary = "RModBus - free implementation of protocol ModBus"
    s.description = "A free Ruby implementation of the ModBus protocol"
    s.email = 'sanderjd@gmail.com'
    s.homepage = 'http://rubyforge.org/var/svn/rmodbus/trunk'
    s.authors = ['Aleksey Timin', 'D.Samatov', 'James Sanders']
    s.has_rdoc = true
    s.files = ["VERSION.yml", 
               "AUTHORS",
               "CHANGES",
               "LICENSE",
               "README",
               "Rakefile",
               "lib/rmodbus", 
               "lib/rmodbus/client.rb", 
               "lib/rmodbus/exceptions.rb", 
               "lib/rmodbus/tcp_client.rb", 
               "lib/rmodbus/tcp_server.rb", 
               "lib/rmodbus.rb", 
               "test/client_spec.rb", 
               "test/ext_spec.rb", 
               "test/rtu_client_spec.rb", 
               "test/tcp_client_spec.rb", 
               "test/tcp_server_spec.rb"]
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com'
end
