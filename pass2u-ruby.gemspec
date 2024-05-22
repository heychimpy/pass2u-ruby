# frozen_string_literal: true

require_relative 'lib/pass2u/version'

Gem::Specification.new do |s|
  s.name = 'pass2u-ruby'
  s.version = Pass2u::VERSION
  s.license = 'MIT'

  s.authors = ["Alexis Dumortier"]
  s.description = "A Ruby interface for the Pass2u API"
  s.email = "tech@heychimpy.com"

  s.files = Dir.glob("{bin,lib}/**/*") + %w(Rakefile README.md LICENSE)
  s.homepage = 'https://github.com/heychimpy/pass2u-ruby'
  s.require_paths = ["lib"]
  s.summary = 'Manages digital passes through the Pass2u API'
  s.test_files = Dir.glob("spec/**/*")

  s.required_ruby_version = '>= 2.7'

  s.add_development_dependency "bundler", ">= 1.17", "< 3.0"
  s.add_development_dependency 'rspec', "~> 3.13"
end
