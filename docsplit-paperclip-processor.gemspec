# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "docsplit-paperclip-processor/version"

Gem::Specification.new do |s|
  s.name        = "docsplit-paperclip-processor"
  s.version     = Docsplit::Paperclip::Processor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tien Le"]
  s.email       = ["tienlx@gmail.com"]
  s.homepage    = "https://github.com/tienle/docsplit-paperclip-processor"
  s.summary     = %q{A Paperclip processor for Docsplit}
  s.description = %q{This gem is simple Paperclip processor which uses Docsplit to convert uploaded files to pdf, or extract information/thumbnails from them}

  s.rubyforge_project = "docsplit-paperclip-processor"

  s.add_dependency "paperclip", "~> 3.1"
  s.add_dependency 'ruby-filemagic'
  s.add_dependency 'docsplit'
  s.add_development_dependency 'bundler', ">= 1.1.4"
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'

  # Runtime dependencies
  s.add_runtime_dependency "paperclip"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
