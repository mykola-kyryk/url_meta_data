# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_meta_data/version'

Gem::Specification.new do |spec|
  spec.name          = "url_meta_data"
  spec.version       = UrlMetaData::VERSION
  spec.authors       = ["Myk Kyryk", "Lana Dzyuban"]
  spec.email         = ["mykola.kyryk@gmail.com", "svitlana.dzyuban@gmail.com"]

  spec.summary       = %q{Visit URL and fetch page title, short description and keywords}
  spec.description   = %q{Visit URL and fetch page title, short description and keywords}
  spec.homepage      = "https://github.com/mykola-kyryk/url_meta_data_fetcher"
  spec.license       = "MIT"

  spec.required_ruby_version = "~> 2.6"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", ">= 1.12.5"

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2.5"
  spec.add_development_dependency "rspec", "> 3.1"
  spec.add_development_dependency "webmock", "> 3.0"
end
