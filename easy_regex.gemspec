# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_regex/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_regex"
  spec.version       = EasyRegex::VERSION
  spec.authors       = ["Fernando Brito, David Leite Guilherme, Jailson Junior Cunha"]
  spec.email         = ["email@fernandobrito.com"]
  spec.description   = %q{A regex engine with simplicity of code in mind. Developed for an university course.}
  spec.summary       = %q{A regex engine with simplicity of code in mind. Developed for an university course.}
  spec.homepage      = "https://github.com/fernandobrito/easy_regex"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
