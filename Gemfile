source 'https://rubygems.org'

ruby '2.5.0'

gem 'rails', '~> 4.2.8'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'rack-timeout'

gem 'bootstrap3-rails'
gem 'bootstrap-material-design'
gem 'material_icons'

gem 'fb_graph2'
gem 'openid_connect'

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'webmock'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'sqlite3'
  gem 'spring'
  gem 'pry-byebug'
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :production, :staging do
  gem 'pg', '~> 0.20'
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end