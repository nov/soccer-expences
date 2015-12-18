require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/lib/'
  add_filter '/app/helpers/'
end
SimpleCov.minimum_coverage 90
