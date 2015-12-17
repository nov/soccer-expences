require 'simplecov'
SimpleCov.start 'rails'
# SimpleCov.minimum_coverage 90

RSpec.configure do |config|
  config.after(:suite) do
    unless ENV['TRAVIS_RUBY_VERSION']
      `open '#{File.join SimpleCov.coverage_path, 'index.html'}'`
    end
  end
end
