# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :coverage do
  desc 'Open coverage report'
  task :report do
    require 'simplecov'
    `open '#{File.join SimpleCov.coverage_path, 'index.html'}'`
  end
end

task :spec do
  Rake::Task[:'coverage:report'].invoke unless ENV['TRAVIS_RUBY_VERSION']
end