source 'https://rubygems.org'

ruby '2.5.0'

gem 'rails', '~> 5.1.6'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'rack-timeout'

gem 'bootstrap3-rails'
gem 'bootstrap-material-design'
gem 'material_icons'

gem 'fb_graph2'
gem 'openid_connect'

group :doc do
  gem 'sdoc'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'webmock'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'sqlite3'
  gem 'spring'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :production, :staging do
  gem 'pg'
  gem 'unicorn'
  gem 'rails_12factor'
end
