# frozen_string_literal: true
begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "rdoc/task"

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title    = "Omniauth::Rails"
  rdoc.options << "--line-numbers"
  rdoc.rdoc_files.include("README.md")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

APP_RAKEFILE = File.expand_path("../spec/test_app/Rakefile", __FILE__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

require "rspec/core"
require "rspec/core/rake_task"

desc "Run all specs in spec directory (excluding plugin specs)"
task("spec").clear
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

require "rubocop/rake_task"
desc "Run RuboCop"
RuboCop::RakeTask.new(:rubocop) do |tsk|
  tsk.fail_on_error = true
  tsk.options = ["-DR", "--format=html", "--out=tmp/rubocop.html", "--format=progress"]
end

task default: [:spec, :rubocop]
