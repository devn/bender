require 'jeweler'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "bender"
  gem.homepage = "http://github.com/bendyworks/bender"
  gem.license = "MIT"
  gem.summary = "Project Management Tools"
  gem.description = "Bite my Shiny Metal Ass!"
  gem.email = "dev@bendyworks.c"+"om"
  gem.authors = ["Nick Karpenske", "Devin Walters", "Jaymes Waters", "Stephen Anderson", "Bradley Grzesiak"]
  gem.default_executable  = "bender"
  gem.executables         = ["bender"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  ['git', 'haml', 'sinatra'].each{|dep| gem.add_runtime_dependency dep}
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new
