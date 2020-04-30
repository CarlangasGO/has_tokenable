# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_tokenable/version"

Gem::Specification.new do |s|

  s.name        = %q{has_tokenable}
  s.version     = HasTokenable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Carlos Montalvo"]
  s.email       = ["carlosmontalvo@zetanova.com"]
  s.homepage    = "https://github.com/CarlangasGO/has_tokenable"
  s.summary     = %q{Identifies your active records with a random token.}
  s.description = %q{Identifies your active records with a random token. For more information, please see the documentation.}
  s.license     = "BSD-2-Clause"
  s.metadata    = { "source_code_uri" => "https://github.com/CarlangasGO/has_tokenable" }

  
  s.files         = `git ls-files`.split("\n")
 
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]


  s.require_paths = ["lib"]

  s.add_dependency('activerecord',  '~> 4')
  s.add_dependency('activesupport', '~> 4')

  s.add_development_dependency('rails',           '~> 4')
  s.add_development_dependency('sqlite3',         '~> 1.3')

end