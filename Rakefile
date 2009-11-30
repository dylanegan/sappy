begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sappy"
    gemspec.summary = "Wrapping that shit!"
    gemspec.description = "A wrapper for the SiteUptime API"
    gemspec.email = ["dylanegan@gmail.com", "tim@spork.in"]
    gemspec.homepage = "http://github.com/abcde/sappy"
    gemspec.authors = ["Dylan Egan", "Tim Carey-Smith"]
    gemspec.files = %w(README.markdown Rakefile VERSION) + Dir.glob("{lib,spec}/**/*")
    gemspec.rubyforge_project = 'abcde'
    gemspec.add_dependency "rack", "1.0.0"
    gemspec.add_dependency "rest-client", "1.0.3"
    gemspec.add_dependency "xml-simple", "1.0.12"
  end

  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'spec/rake/spectask'
desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)

  t.rcov = ENV['RCOV'] == "true"
  t.rcov_opts << '--exclude' << 'spec'
  t.rcov_opts << '--text-summary'
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
end

desc 'Default: Runs rspec'
task :default => :spec
