$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-rails"
  s.version     = Omniauth::Rails::VERSION
  s.authors     = ["Dan Rabinowitz"]
  s.email       = [""]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Omniauth::Rails."
  s.description = "TODO: Description of Omniauth::Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
