source 'https://gems.ruby-china.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# using puma as default server
gem 'puma'

# pagination
gem 'kaminari'

gem 'sinatra', require: false

gem 'whenever'

# for background job schedule
gem 'sidekiq', '< 5'

# for cache
gem 'redis'

# for file upload
gem 'carrierwave'

# for http api call
gem 'httparty'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'test_after_commit'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'mocha', '~> 0.14.0', require: false
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'minitest-reporters'
  gem 'faker'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'simplecov', require: false, group: :test
end

group :development do
  gem 'capistrano-bundler', require: false
  gem 'capistrano', '3.5.0', require: false
  gem 'capistrano-rails', '1.1.3'
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'annotate', '>=2.5.0'
  gem 'spring'
  gem 'web-console'
  gem 'pry-byebug'
end

