# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dubot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Wataru MIYAGUNI"]
  gem.email         = ["gonngo@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.name          = "dubot"
  gem.require_paths = ["lib"]
  gem.version       = Dubot::VERSION

  gem.add_runtime_dependency 'redis'
  gem.add_runtime_dependency 'thor'
end
