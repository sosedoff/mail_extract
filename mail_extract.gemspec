# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mail_extract/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'mail_extract'
  gem.version     = MailExtract::VERSION.dup
  gem.author      = 'Dan Sosedoff'
  gem.email       = 'dan.sosedoff@gmail.com'
  gem.homepage    = 'https://github.com/sosedoff/mail_extract'
  gem.summary     = %q{Extracts email message body}
  gem.description = %q{Email body parser that strips out all quotes and signatures.}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.6'
end