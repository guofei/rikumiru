source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# gem 'jquery-turbolinks', '~> 2.1.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'
gem 'puma', '~> 2.11.3'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
group :development, :test do
  gem 'byebug'

  gem 'rspec-rails', '~> 3.0.2'
  gem 'factory_girl_rails', '~> 4.4.1'
end

group :development do
  # Be sure to require rack_mini_profiler below the pg and mysql gems in your Gemfile.
  gem 'rack-mini-profiler'
  # N+1 queries
  gem "bullet"
  gem 'guard'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'sqlite3'
  gem 'database_cleaner', '~> 1.3.0'
end

gem 'rails_12factor', group: :production

gem 'bootstrap-sass', '~> 3.2.0.1'
gem 'font-awesome-rails', '~> 4.2.0.0'

gem 'kaminari', '~> 0.16.1'
gem 'kaminari-i18n', '~> 0.2.0'

gem 'rails-i18n', '~> 4.0.4'

gem 'devise', '~> 3.2.4'
gem 'devise-i18n', '~> 0.10.4'
gem 'cancancan', '~> 1.9.2'

gem 'google-analytics-turbolinks'
gem 'fb-channel-file'

gem 'ransack', '~> 1.2.3'

gem 'acts_as_commentable'
gem 'simple_captcha2', '~> 0.3.4'

gem 'simple_form', '~> 3.1.0.rc2'

gem 'redis-store'
gem 'redis-rails'
gem 'redis-objects', '~> 1.0.0'

gem 'high_voltage', '~> 2.2.1'

gem 'chartkick', '~> 1.3.2'

gem 'tf-idf-similarity'

gem 'newrelic_rpm'

gem 'validates_email_format_of'
