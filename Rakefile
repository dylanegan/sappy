require 'bundler'
require 'jeweler'

begin
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sappy"
    gemspec.summary = "Wrapping that shit!"
    gemspec.description = "A wrapper for the SiteUptime API"
    gemspec.email = ["dylanegan@gmail.com", "tim@spork.in"]
    gemspec.homepage = "http://github.com/abcde/sappy"
    gemspec.authors = ["Dylan Egan", "Tim Carey-Smith"]
    # reject people's local copies of credentials
    project_files = Dir.glob("{lib,spec}/**/*").reject { |file| file =~ %r!spec/credentials.rb! }

    gemspec.files = %w(README.markdown Rakefile VERSION) + project_files
    gemspec.rubyforge_project = 'abcde'

    bundle = Bundler::Definition.from_gemfile("Gemfile")
    bundle.dependencies.
      select { |d| d.groups.include?(:runtime) }.
      each   { |d| gemspec.add_dependency(d.name, d.version_requirements.to_s)  }
  end

  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
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
