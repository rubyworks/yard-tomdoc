# Rubytest Configuration

Test.run do |r|
  r.loadpath << 'lib'
  r.loadpath << 'test'
  r.files << 'test/unit/test_*.rb'
end

Test.run 'coverage' do |r|
  r.loadpath << 'lib'
  r.loadpath << 'test'
  r.files << 'test/unit/test_*.rb'
  r.before do
    require 'simplecov'
    SimpleCov.command_name 'Ruby Tests'
    SimpleCov.start do
      add_filter '/test/'
      coverage_dir('log/coverage')
    end
  end
end

