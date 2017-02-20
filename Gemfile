source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'rails-api', '~> 0.4.0'

gem 'active_model_serializers', '~> 0.8.3'

gem 'devise', '~> 3.4.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'

gem 'thin'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc


group :development do
	gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'capybara', '~> 2.5'
  gem 'ffaker', :git => 'https://github.com/EmmanuelOga/ffaker.git'
  gem "shoulda-matchers", "~>2.5"
end

group :test do
  gem "rspec-rails", "~> 2.14"
  gem "factory_girl_rails"
  gem 'database_cleaner'
  gem "shoulda-matchers", "~>2.5"
end

