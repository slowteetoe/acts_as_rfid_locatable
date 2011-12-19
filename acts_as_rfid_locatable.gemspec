$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_rfid_locatable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_rfid_locatable"
  s.version     = ActsAsRfidLocatable::VERSION
  s.authors     = ["Steven Lotito"]
  s.email       = ["steven.lotito@alumni.pitt.edu"]
  s.homepage    = "http://github.com/slowteetoe/acts_as_rfid_locatable"
  s.summary     = "Rails plugin to allow tracking assets via RFID tags"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"

  s.add_development_dependency "sqlite3"
end
