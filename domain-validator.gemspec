# encoding: utf-8
require File.join(File.dirname(__FILE__), 'lib/domain_validator/version')

Gem::Specification.new do |s|
  s.name        = 'domain-validator'
  s.license     = 'MIT'
  s.version     = DomainValidator::VERSION
  s.authors     = ['Alexey Vokhmin', 'Dave Perrett', 'Oleg Dashevskii']
  s.email       = ['avokhmin@gmail.com', 'dave@recurser.com', 'be9@be9.ru']
  s.homepage    = 'https://github.com/Shuttlerock/domain_validator'
  s.summary     = 'ActiveModel validations for domains with fully localization support.'
  s.description = 'ActiveModel validations for domains with fully localization support.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activemodel', '>= 3.0.0'
  s.add_development_dependency 'activesupport', '>= 3.0.0'
  s.add_development_dependency 'rspec'
end
