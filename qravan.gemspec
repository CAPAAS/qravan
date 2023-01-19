# frozen_string_literal: true

require_relative "lib/qravan/version"

Gem::Specification.new do |spec|
  spec.name          = "qravan"
  spec.version       = Qravan::VERSION
  spec.authors       = ["apanasenkov@capaa.ru"]
  spec.email         = ["apanasenkov@capaa.ru"]

  spec.summary       = "Qravan simple API server for data requests."
  spec.homepage      = "https://qravan.ru"
  spec.required_ruby_version = ">= 3.0.2"
  spec.licenses = ["Nonstandard"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/capaas/qravan"
  spec.metadata["changelog_uri"] = "https://github.com/capaas/qravan/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/qravan/extconf.rb"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rack", "~> 3.0.4.1"
  spec.add_dependency "rack-unreloader", ">= 1.8"

  spec.add_dependency "async", "~> 1.30.1"
  spec.add_dependency "async-http", "~> 0.59.2"
  spec.add_dependency "async-io", "~> 1.34.1"
  spec.add_dependency "async-sequel", "~> 0.1.0"
  spec.add_dependency "falcon", "~> 0.42.3"
  spec.add_dependency "logger", ">=1.5.3"
  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "redis", "~>5.0.5"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "rubocop", "~> 1.7"
  spec.add_dependency "sequel", ">= 5.62"
  spec.add_dependency "sequel_pg", ">= 1.8"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
