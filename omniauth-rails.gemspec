# frozen_string_literal: true
$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-rails"
  s.version     = Omniauth::Rails::VERSION
  s.authors     = ["Dan Rabinowitz"]
  s.email       = ["djr@DanielRabinowitz.com"]
  s.homepage    = "https://github.com/danrabinowitz/omniauth-rails"
  s.summary     = "A Rails Engine to make it as easy as possible to add oauth " \
                  "authentication to a Rails app."
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "awesome_print" # Useful for debugging
  s.add_development_dependency "simplecov"
  s.add_development_dependency "simplecov-console"
  s.add_development_dependency "dotenv-rails"
  s.add_development_dependency "brakeman"
  s.add_development_dependency "omniauth-google-oauth2"

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency "omniauth"
end
