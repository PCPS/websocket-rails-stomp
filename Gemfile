source 'https://rubygems.org'

# Specify your gem's dependencies in websocket-rails-stomp.gemspec
gemspec

gem "websocket-rails", path: "~/code/ruby/websocket-rails-rp"

gem "guard"
gem "guard-rspec"
gem "guard-bundler"
gem "terminal-notifier-guard"

platforms :jruby do
  gem 'activerecord-jdbcsqlite3-adapter', :require => 'jdbc-sqlite3', :require => 'arjdbc'
end
platforms :ruby do
  gem 'sqlite3'
end
