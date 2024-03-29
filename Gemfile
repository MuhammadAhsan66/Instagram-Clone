# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.7'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# For notification purpose
gem 'toastr-rails'
# Simple, efficient background processing for Ruby.
gem 'sidekiq', '~> 6.4', '>= 6.4.2'

# A RuboCop extension focused on enforcing Rails best practices and coding conventions.
gem 'rubocop', '~> 1.30'
gem 'rubocop-minitest', '~> 0.20.1'
gem 'rubocop-performance', '~> 1.14'
gem 'rubocop-rails', '~> 2.14', '>= 2.14.2'

# Authentication purpose
gem 'devise'

# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.2'

# For file validation purpose
gem 'file_validators', '~> 3.0'

# For uploading of files
gem 'carrierwave', '~> 2.2', '>= 2.2.2'
gem 'cloudinary', '~> 1.23'

# To make it easy to securely configure Rails applications.
gem 'figaro', '~> 1.2'

# Use SCSS for stylesheets
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'

# Agnostic pagination in plain ruby. It does it all. Better.
gem 'pagy', '~> 5.10', '>= 5.10.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  # minitest provides a complete suite of testing facilities
  gem 'minitest', '~> 5.8', '>= 5.8.4'
  # Code coverage for Ruby with a powerful configuration library a
  gem 'simplecov', '~> 0.21.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
