# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'like'
  spec.version       = '0.2.1'
  spec.authors       = ['Pat Allan']
  spec.email         = ['pat@freelancing-gods.com']
  spec.summary       = %q{Rails Engine for liking}
  spec.description   = %q{A simple Rails engine for liking ActiveRecord objects.}
  spec.homepage      = 'https://github.com/inspire9/like'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rails', '>= 3.2'

  spec.add_development_dependency 'capybara',    '>= 2.2.0'
  spec.add_development_dependency 'combustion',  '~> 0.5'
  spec.add_development_dependency 'devise',      '>= 3.2.2'
  spec.add_development_dependency 'grape',       '~> 0.5'
  spec.add_development_dependency 'mime-types',  '>= 1.16'
  spec.add_development_dependency 'rspec-rails', '~> 3.8'
  spec.add_development_dependency 'sqlite3',     '~> 1.3.8'
end
