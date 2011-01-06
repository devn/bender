Gem::Specification.new do |s|
  s.name                = "bender"
  s.version             = "0.0.1"

  s.summary             = "Project Bender"
  s.description         = "Bite my Shiny Metal Ass!"
  s.authors             = ["Nick Karpenske", "Devin Walters", "Jaymes Waters", "Stephen Anderson", "Bradley Grzesiak"]
  s.email               = "dev@bendyworks.c"+"om"
  s.homepage            = "http://github.com/bendyworks/bender"
  s.default_executable  = "bender"
  s.executables         = ["bender"]
  s.files               = [
    "README.md",
    "bender.gemspec",
    "bin/bender",
    "lib/bender.rb",
    "lib/bender/runner.rb"
  ]
end
