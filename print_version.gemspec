# frozen_string_literal: true

require_relative "lib/print_version/version"

Gem::Specification.new do |spec|
  spec.name = "print_version"
  spec.version = PrintVersion::VERSION
  spec.authors = ["David Rodríguez"]
  spec.email = ["deivid.rodriguez@riseup.net"]

  spec.summary = "Prints its own version when required"
  spec.description = "Prints its own version when required"
  spec.homepage = "https://example.org"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
