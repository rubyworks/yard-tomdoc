
config 'rubytest' do |run|
  require 'spectroscope'
  require 'ae'

  $:.unshift 'lib'
  $:.unshift 'test'

  run.files << 'test/**/test_*.rb'
end

