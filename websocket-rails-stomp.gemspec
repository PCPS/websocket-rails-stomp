# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'websocket_rails/stomp/version'

Gem::Specification.new do |spec|
  spec.name          = "websocket-rails-stomp"
  spec.version       = WebsocketRails::Stomp::VERSION
  spec.authors       = ["Dan Knox"]
  spec.email         = ["dknox@threedotloft.com"]
  spec.summary       = %q{A STOMP protocol extension for websocket-rails}
  spec.description   = %q{A STOMP protocol extension for websocket-rails}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir["{lib,spec}/**/*"] + ["LICENSE.txt", "Rakefile", "Gemfile", "README.md"]
  spec.test_files    = Dir["{spec}/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails"
  #spec.add_runtime_dependency "websocket-rails"
  spec.add_runtime_dependency "stomp"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", "~> 2.14.0"
end
