source "http://rubygems.org"

# Specify your gem's dependencies in guard-webrick.gemspec
gemspec

group :development do
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
end

group :test do
  gem 'rake', '~> 10.4'
end

platforms :jruby do
  gem 'jruby-openssl'
end
