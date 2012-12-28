# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_dates/version'

Gem::Specification.new do |gem|
  gem.name        = 'easy_dates'
  gem.version     = EasyDates::VERSION
  gem.summary     = "Easy date formatting for ActiveRecord"
  gem.description = "Easy date formatting for ActiveRecord"
  gem.authors     = ["Ryan Oberholzer", "Eric Hankinson"]
  gem.email       = 'ryan at platform45.com'
  gem.files       = `git ls-files`.split($/)
  gem.homepage    = 'http://rubygems.org/gems/easy_dates'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
