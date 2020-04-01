
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "xteam/version"

Gem::Specification.new do |spec|
  spec.name          = "xteam"
  spec.version       = Xteam::VERSION
  spec.authors       = ["gg19910817"]
  spec.email         = ["gg19910817@gmail.com"]

  spec.summary       = "xteam"
  spec.description   = "xteam"
  spec.homepage      = "https://github.com/gg19910817/xteam"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = %w{ xteam }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "molinillo", ">= 0.5.5"
  spec.add_development_dependency "claide", "~> 1.0"
  spec.add_development_dependency "colored2", "~> 3.1"
  spec.add_development_dependency "cocoapods", "~> 1.9"
end
