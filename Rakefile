require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

task :console do
  exec "irb", "-r", "bundler/setup", "-r", "econfig-keychain"
end

task default: :spec
