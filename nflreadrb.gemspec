# frozen_string_literal: true

require_relative "lib/nflreadrb/version"

Gem::Specification.new do |spec|
  spec.name = "nflreadrb"
  spec.version = Nflreadrb::VERSION
  spec.authors = ["Joshua Pearson"]
  spec.email = ["joshua.david.pearson@gmail.com"]

  spec.summary = "A high-performance, cached Parquet data loader for nflverse datasets."
  spec.description = "Leverages Polars and local filesystem caching to stream, select, and filter production nflverse data files with sub-5ms latency."
  spec.homepage = "https://github.com/kibosh-josh/nflreadrb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kibosh-josh/nflreadrb"
  spec.metadata["changelog_uri"] = "https://github.com/kibosh-josh/nflreadrb/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Core runtime dependency
  spec.add_dependency "polars-df"
end
