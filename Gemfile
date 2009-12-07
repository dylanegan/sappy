only :release do
  gem "rack",        "1.0.0"
  gem "rest-client", "~>1.0.3"
  gem "nokogiri"
end

only :test do
  gem "rake"
  gem "rspec", :require_as => 'spec'
  gem "fakeweb",   "1.2.5"
  gem "ruby-debug"
  gem "ZenTest"
  gem 'rcov'
  gem 'bundler'
  gem 'jeweler'
end

bundle_path "tmp/vendor"
bin_path "tmp/bin"
disable_system_gems
