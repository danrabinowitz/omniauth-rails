require 'rspec/core'
require "simplecov-console"
SimpleCov::Formatter::Console.table_options = {max_width: 180}
SimpleCov.formatter = SimpleCov::Formatter::Console

if RSpec.configuration.files_to_run.size > 1
  SimpleCov.start 'rails' do
  end
end
