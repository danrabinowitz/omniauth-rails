# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../spec/test_app/config/environment.rb", __FILE__)
require "rails/test_help"
