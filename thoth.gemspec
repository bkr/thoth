# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thoth/version'

Gem::Specification.new do |spec|
  spec.name          = "thoth"
  spec.version       = Thoth::VERSION
  spec.authors       = ["Philippe Huibonhoa"]
  spec.email         = ["phuibonhoa@gmail.com"]
  spec.summary       = %q{Easy event logging for rails.}
  spec.homepage      = "https://github.com/bkr/thoth"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', ['>= 3.0', '< 5.0']
  spec.add_dependency 'request_store'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rails', '~> 3.2.18'
  spec.add_development_dependency 'rspec-rails', '~> 2.14'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'timecop'
end
