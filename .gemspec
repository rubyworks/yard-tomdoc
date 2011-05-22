--- !ruby/object:Gem::Specification 
name: yard-tomdoc
version: !ruby/object:Gem::Version 
  hash: 23
  prerelease: 
  segments: 
  - 0
  - 2
  - 0
  version: 0.2.0
platform: ruby
authors: 
- Loren Segal
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-05-22 00:00:00 Z
dependencies: 
- !ruby/object:Gem::Dependency 
  name: tomdoc
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 23
        segments: 
        - 0
        - 2
        - 0
        version: 0.2.0
  type: :runtime
  version_requirements: *id001
- !ruby/object:Gem::Dependency 
  name: ko
  prerelease: false
  requirement: &id002 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id002
- !ruby/object:Gem::Dependency 
  name: redline
  prerelease: false
  requirement: &id003 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id003
description: Implements [TomDoc](http://tomdoc.org) syntax for YARD. 'Nuff said.
email: transfire@gmail.com
executables: []

extensions: []

extra_rdoc_files: 
- README.md
files: 
- lib/.yardoc/checksums
- lib/.yardoc/objects/root.dat
- lib/.yardoc/proxy_types
- lib/yard-tomdoc/tomdoc.rb
- lib/yard-tomdoc.rb
- test/case_docstring.rb
- HISTORY.md
- README.md
- VERSION
- MIT.txt
- NOTICE.md
homepage: http://rubyworks.github.com/yard-tomdoc
licenses: 
- MIT
post_install_message: 
rdoc_options: 
- --title
- YARD-TomDoc API
- --main
- README.md
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
requirements: []

rubyforge_project: yard-tomdoc
rubygems_version: 1.8.2
signing_key: 
specification_version: 3
summary: TomDoc for YARD
test_files: []

