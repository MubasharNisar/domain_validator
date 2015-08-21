#!/usr/bin/env rake

require 'rspec/core/rake_task'
require File.dirname(__FILE__) + '/lib/domain_validator/version'

task :default => :test

task :build => :test do
  system 'gem build domain-validator.gemspec'
end

task :release => :build do
  # tag and push
  system "git tag v#{DomainValidator::VERSION}"
  system "git push origin --tags"
  # push the gem
  system "gem push domain-validator-#{DomainValidator::VERSION}.gem"
end

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.fail_on_error = true # be explicit
end
