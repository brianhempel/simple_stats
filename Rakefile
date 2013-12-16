require "bundler/gem_tasks"

task :default => :test

desc "Run the tests (rspec)"
task(:test) do
  require 'rspec/autorun'
  Dir.glob(File.expand_path '../spec/**/*_spec.rb', __FILE__).each {|s| require s}
end
