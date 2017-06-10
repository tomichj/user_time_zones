$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'user_time_zones/version'

Gem::Specification.new do |spec|
  spec.name          = 'user_time_zones'
  spec.version       = UserTimeZones::VERSION
  spec.authors       = ['Justin Tomich']
  spec.email         = ['justin@tomich.org']
  spec.homepage      = 'http://github.com/tomichj/user_time_zones'
  spec.summary       = 'Provide time zone support for User models in Rails applications'
  spec.description   = 'Provide time zone support for User models in Rails applications'
  spec.license       = 'MIT'


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.test_files = `git ls-files -- {spec}/*`.split("\n")

  spec.require_paths = ['lib']

  spec.extra_rdoc_files = %w(LICENSE README.md CHANGELOG.md)
  spec.rdoc_options = ['--charset=UTF-8']

  # probably reduce to railtie or ...
  spec.add_dependency 'rails', '>= 5.0', '< 5.2'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'authenticate'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.0')
end
