# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','jstats_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'jstats'
  s.version = Jstats::VERSION
  s.author = 'Simon Caplette'
  s.homepage = 'https://github.com/simcap/jstats'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Outputs Java projects statistics from the command line'
# Add your other files here if you make them
  s.files = %w(
bin/jstats
lib/jstats_version.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','jstats.rdoc']
  s.rdoc_options << '--title' << 'jstats' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'jstats'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_runtime_dependency('gli')
  s.add_runtime_dependency('javaparse')
  s.add_runtime_dependency('terminal-table')
end
