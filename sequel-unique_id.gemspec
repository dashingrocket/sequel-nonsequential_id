# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'sequel-nonsequential_id'
  spec.version       = '1.2.1-dev'
  spec.authors       = ['Jesse Bowes']
  spec.email         = ['jbowes@dashingrocket.com']
  spec.summary       = 'Sequel Non-Sequential Unique ID Plugin'
  spec.description   = 'Automatically generate non-sequential (pseudo-random) IDs for Sequel Models'
  spec.homepage      = 'https://github.com/dashingrocket/sequel-nonsequential_id'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'sequel', '~> 5.0'

  spec.add_development_dependency 'test-unit', '~> 3.2'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'mocha', '~> 1.7'
end
