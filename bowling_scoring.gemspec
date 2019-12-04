# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bowling_scoring/version'
require 'bowling_scoring/authors'
require 'bowling_scoring/emails'

Gem::Specification.new do |spec|
  spec.name          = 'bowling_scoring'
  spec.version       = BowlingScoring::VERSION
  spec.authors       = BowlingScoring::AUTHORS
  spec.email         = BowlingScoring::EMAILS

  spec.summary       = 'Simple bowling scoring formatter command line app'
  spec.homepage      = 'https://github.com/castromon95/bowling_scoring'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0', '>= 2.0.2'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.77.0'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
  spec.add_development_dependency 'tty-prompt', '~> 0.19.0'
end
