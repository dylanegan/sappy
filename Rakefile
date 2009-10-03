begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sappy"
    gemspec.summary = "Wrapping that shit!"
    gemspec.description = "A wrapper for the SiteUptime API"
    gemspec.email = ["dylanegan@gmail.com", "tim@spork.in"]
    gemspec.homepage = "http://github.com/abcde/sappy"
    gemspec.authors = ["Dylan Egan", "Tim Carey-Smith"]
    gemspec.files = %w(README.markdown Rakefile VERSION) + Dir.glob("{lib,bacon}/**/*")
    gemspec.rubyforge_project = 'abcde'
  end

  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc 'Run bacon'
task :bacon do
  puts `bacon #{Dir["spec/**/*_bacon.rb"].join(" ")}`
end

desc 'Default: Runs spec'
task :default => :bacon
