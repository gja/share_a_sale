# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'share_a_sale/version'

Gem::Specification.new do |spec|
  spec.name          = "share_a_sale"
  spec.version       = ShareASale::VERSION
  spec.authors       = ["Tejas Dinkar"]
  spec.email         = ["tejas@gja.in"]
  spec.description   = %q{Gem to share sales via the Share a Sale Network}
  spec.summary       = %q{Gem to share sales via the Share a Sale Network}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
