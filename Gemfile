source 'https://rubygems.org'

# RAILS
gem 'rails', '~> 5.0.0'

# APPLICATION SERVER
gem 'puma', '~> 3.0'

# DB
gem 'pg', '~> 0.18'

# AUTHENTICATION
gem 'devise'

# VIEW RELATED
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass'

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'capistrano', '~> 3.6'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.4'
  gem 'rspec-collection_matchers'
  gem 'factory_girl_rails', '~> 4.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver', '~> 2.53'
  gem 'headless', require: false
  gem 'database_cleaner'
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
end
