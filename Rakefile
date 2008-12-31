require 'rake/gempackagetask'

require File.dirname(__FILE__) + '/lib/sappy/version'

GEM_NAME = "sappy"
GEM_VERSION = Sappy::VERSION
AUTHORS = %w( abcde halorgium )
EMAIL = "degan@engineyard.com tcareysmith@engineyard.com"
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

desc "Release the version"
task :release do
  version = GEM_VERSION
  puts "Releasing #{version}"

  `git show-ref tags/v#{version}`
  unless $?.success?
    abort "There is no tag for v#{version}"
  end

  `git show-ref heads/releasing`
  if $?.success?
    abort "Remove the releasing branch, we need it!"
  end

  puts "Checking out to the releasing branch as the tag"
  system("git", "checkout", "-b", "releasing", "tags/v#{version}")

  puts "Uploading gem to internal gem server"
  ENV.delete("GEM_PATH")
  %x{ samurai gem_upload #{GEM_NAME} #{version} }

  puts "Reseting back to master"
  system("git", "checkout", "master")
  system("git", "branch", "-d", "releasing")

  ints = Gem::Version.new(version).ints << 0
  next_version = Gem::Version.new(ints.join(".")).bump

  puts "Changing the version to #{next_version}."

  version_file = "lib/#{GEM_NAME}/version.rb"
  File.open(version_file, "w") do |f|
    f.puts <<-EOT
module Sappy
  VERSION = "#{next_version}"
end
    EOT
  end

  puts "Committing the version change"
  system("git", "add", version_file)
  system("git", "commit", "-m", "Next version: #{next_version}")

  puts "Push the commit up! if you don't, you'll be hunted down"
end
