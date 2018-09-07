$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smoney/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smoney"
  s.version     = Smoney::VERSION
  s.authors     = ["Luc Traonmilin", "Arnaud Sellenet"]
  s.homepage    = "https://github.com/enerfip/smoney-rb"
  s.summary     = "Smoney Ruby API Client."
  s.description = "Smoney Ruby API Client."
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "json"
  s.add_development_dependency "minitest"
end
