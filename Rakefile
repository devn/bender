begin; require 'rubygems'; rescue LoadError; end
require 'rake'
Dir[File.expand_path(File.join("lib/tasks/*.rake"))].each {|f| load f}

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--color"
    t.pattern = "spec/**/*_spec.rb"
  end
  task :default => :spec
rescue LoadError
end
