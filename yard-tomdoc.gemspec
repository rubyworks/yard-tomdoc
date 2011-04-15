#!/usr/bin/env ruby

version = File.read('VERSION')

Gem::Specification.new do |s|
  s.name = "yard-tomdoc"
  s.version = version
  s.platform = Gem::Platform::RUBY
  s.authors = ["Loren Segal"]
  s.email = ["lsegal@soen.ca"]
  s.homepage = "https://github.com/lsegal/yard-tomdoc"
  s.summary = %q{Tomdoc syntax for YARD}
  s.description = %q{Generate YARD docs from scripts documented using Tomdoc syntax standard.}
  s.rubyforge_project = "yard-tomdoc"
  s.add_development_dependency "rspec"
  #s.add_development_dependency "simplecov", [">= 0.3.8"] #, :require => false
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.extra_rdoc_files = ["README.md"]
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "yard-tomdoc", "--main", "README.md"]
  #post_install_message = %q{}
end

