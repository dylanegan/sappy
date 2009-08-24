# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sappy}
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dylan Egan", "Tim Carey-Smith"]
  s.date = %q{2009-08-24}
  s.default_executable = %q{shell}
  s.description = %q{A wrapper for the SiteUptime API}
  s.email = ["dylanegan@gmail.com", "tim@spork.in"]
  s.executables = ["shell"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "Rakefile",
     "VERSION",
     "bacon/account_bacon.rb",
     "bacon/helper.rb",
     "bacon/monitor_bacon.rb",
     "bacon/xml/monitor_list.xml",
     "lib/core_ext.rb",
     "lib/core_ext/module/boolean_accessor.rb",
     "lib/sappy.rb",
     "lib/sappy/account.rb",
     "lib/sappy/monitor.rb",
     "lib/sappy/request.rb",
     "lib/sappy/response.rb",
     "lib/sappy/responses.rb",
     "lib/sappy/responses/account_info.rb",
     "lib/sappy/responses/add_monitor.rb",
     "lib/sappy/responses/auth.rb",
     "lib/sappy/responses/disable_monitor.rb",
     "lib/sappy/responses/edit_monitor.rb",
     "lib/sappy/responses/enable_monitor.rb",
     "lib/sappy/responses/error.rb",
     "lib/sappy/responses/monitors.rb",
     "lib/sappy/responses/remove_monitor.rb",
     "lib/sappy/responses/summary_statistics.rb"
  ]
  s.homepage = %q{http://github.com/abcde/sappy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Wrapping that shit!}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
