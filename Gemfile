source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0.rc1'
gem 'pg'
gem 'rails_config'

gem 'activerecord-postgis-adapter'

gem 'unicorn'

gem 'awesome_print', require: nil
gem 'oj'
gem 'hiredis'
gem 'redis', require: %w(redis/connection/hiredis redis)
gem 'active_model_serializers'
gem 'pry-rails'

group :doc do
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails', '~> 2.0'
end

# gem 'debugger', group: [:development, :test]

group :test do
  gem 'simplecov', require: nil
  gem 'syntax', require: nil
  gem 'rr', require: nil
end
