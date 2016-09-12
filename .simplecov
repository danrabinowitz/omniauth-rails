require 'rspec/core'
require "simplecov-console"
SimpleCov.formatter = SimpleCov::Formatter::Console

if RSpec.configuration.files_to_run.size > 1
  SimpleCov.start 'rails' do
  end
end


# TODO: This is a hideous monkey patch.
module Hirb::View
  warn_level = $VERBOSE
  $VERBOSE = nil
  DEFAULT_WIDTH = 180
  $VERBOSE = warn_level
end
