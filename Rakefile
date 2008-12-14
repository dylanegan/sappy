require 'rake/gempackagetask'

require File.dirname(__FILE__) + '/lib/site_uptime_api/version'

GEM_NAME = "site_uptime_api"
GEM_VERSION = SiteUptimeAPI::VERSION
AUTHORS = %w( abcde )
EMAIL = "degan@engineyard.com"
HOMEPAGE = "https://github.com/abcde/site_uptime_api"
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
  s.files = %w(README Rakefile) + Dir.glob("lib/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

require 'spec/rake/spectask'
desc "Run specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << %w(-fs --color) << %w(-O spec/spec.opts)
  t.spec_opts << '--loadby' << 'random'
  t.spec_files = %w(models).collect { |dir| Dir["spec/#{dir}/**/*_spec.rb"] }.flatten
end

desc 'Default: run spec examples'
task :default => 'spec'
