# frozen_string_literal: true

require_relative 'lib/random_data_generator/version'

Gem::Specification.new do |spec|
  spec.name        = 'random_data_generator'
  spec.version     = RandomDataGenerator::VERSION
  spec.authors     = ['vgartg']
  spec.email       = ['gopik539@mail.ru']
  spec.summary     = 'A Ruby library and web app for generating random data.'
  spec.description = 'Generates random strings, numbers, dates, addresses, ' \
                     'colors, emails, phones, and more. Ships with a Sinatra ' \
                     'API and a Vite/TypeScript frontend.'
  spec.homepage    = 'https://github.com/vgartg/PET_Random-Data-Generator'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.files = Dir['lib/**/*.rb'] + Dir['resources/**/*'] + %w[LICENSE.txt README.md]
  spec.require_paths = ['lib']

  spec.add_dependency 'puma', '~> 6.4'
  spec.add_dependency 'rack', '~> 3.1'
  spec.add_dependency 'rackup', '~> 2.2'
  spec.add_dependency 'sinatra', '~> 4.1'
  spec.add_dependency 'sinatra-contrib', '~> 4.1'

  spec.metadata = {
    'source_code_uri' => 'https://github.com/vgartg/PET_Random-Data-Generator',
    'bug_tracker_uri' => 'https://github.com/vgartg/PET_Random-Data-Generator/issues',
    'rubygems_mfa_required' => 'true'
  }
end
