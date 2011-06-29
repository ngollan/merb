#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb-gen/version', __FILE__)

require 'date'

Gem::Specification.new do |gem|
  gem.name        = 'merb-gen'
  gem.version     = Merb::Generators::VERSION.dup
  gem.date        = Date.today.to_s
  gem.authors     = ['Jonas Nicklas']
  gem.email       = 'jonas.nicklas@gmail.com'
  gem.homepage    = 'http://merbivore.com/'
  gem.description = 'Merb plugin containing useful code generators'
  gem.summary     = 'Merb plugin that provides a suite of code generators for Merb.'

  gem.require_paths = ['lib']
  gem.files = Dir['Rakefile', '{bin,lib,spec,docs}/**/*', 'README*', 'LICENSE*', 'TODO*'] & `git ls-files -z`.split("\0")

  # Runtime dependencies
  gem.add_dependency 'merb-core', "~> #{Merb::VERSION}"
  gem.add_dependency 'thor'

  # Development dependencies
  gem.add_development_dependency 'rspec', '>= 2.5'

  # Executable files
  gem.executables  = 'merb-gen'
end
