require 'rake/gempackagetask'

require File.dirname(__FILE__) + '/lib/sappy/version'

GEM_NAME = "sappy"
GEM_VERSION = Sappy::VERSION
AUTHORS = %w( abcde )
EMAIL = "degan@engineyard.com"
HOMEPAGE = "https://github.com/abcde/sappy"
SUMMARY = "A wrapper for the SiteUptime API"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = GEM_NAME
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.files = %w(README Rakefile) + Dir.glob("{lib,bacon}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Run bacon"
task :bacon do
  puts `bacon #{Dir["bacon/**/*_bacon.rb"].join(" ")}`
end

desc 'Default: run bacon'
task :default => :bacon
