# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_meta_data_fetcher/version'

Gem::Specification.new do |spec|
  spec.name          = "url_meta_data_fetcher"
  spec.version       = UrlMetaDataFetcher::VERSION
  spec.authors       = ["Myk Kyryk", "Lana Dzyuban"]
  spec.email         = ["mykola.kyryk@gmail.com", "svitlana.dzyuban@gmail.com"]

  spec.summary       = %q{Visit URL and fetch page title, short description and keywords}
  spec.description   = %q{Visit URL and fetch page title, short description and keywords}
  spec.homepage      = "https://github.com/mykola-kyryk/url_meta_data_fetcher"
  spec.license       = "MIT"

  spec.required_ruby_version = '~> 2.3'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
