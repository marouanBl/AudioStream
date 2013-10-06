# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'audiostream/version'

Gem::Specification.new do |spec|
  spec.name          = "audiostream"
  spec.version       = Audiostream::VERSION
  spec.authors       = ["Dwight Spencer"]
  spec.email         = ["dspencer@dapla.net"]
  spec.description   = %q{Streaming Audio administration toolkit}
  spec.summary       = %q{Streaming Audio administration toolkit}
  spec.homepage      = ""
  spec.license       = "BSD version 2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "iconv"
  spec.add_dependency "mp3info"
  spec.add_dependency "m3uzi"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
