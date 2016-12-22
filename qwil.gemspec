$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "qwil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "qwil"
  s.version     = Qwil::VERSION
  s.authors     = ["Tomas Becklin"]
  s.email       = ["tomasbecklin@gmail.com"]
  s.homepage    = "https://github.com/DroneBase/Qwil"
  s.summary     = "Ruby bindings for the Qwil API: https://staging.qwil.co/docs/"
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-nc"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "mocha"
end
