# -*- ruby -*-
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'naming/version'

Gem::Specification.new do |gem|
  gem.name          = "naming"
  gem.version       = Naming::VERSION
  gem.authors       = ["Keita Yamaguchi"]
  gem.email         = ["keita.yamaguchi@gmail.com"]
  gem.description   = "naming provides name and value container with useful functions"
  gem.summary       = "naming provides name and value container with useful functions"
  gem.homepage      = "https://github.com/keita/naming"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "forwardablex", "~> 0.1.4"
  gem.add_dependency "structx", "~> 0.1.0"

  gem.add_development_dependency "bacon"
end
