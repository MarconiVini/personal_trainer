source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'bcrypt-ruby', :require =>  'bcrypt'
# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',    '~> 3.2.3'
  gem 'coffee-rails',  '~> 3.2.1'
  gem 'uglifier',      '>= 1.0.3'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger

group :development, :test do
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec', '0.5.5'
  gem 'sqlite3' 
  gem 'debugger'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'capybara', '1.1.2'
  gem 'rb-inotify', '0.8.8'
  gem 'libnotify', '0.5.9'
  gem 'guard-spork', '0.3.2'
  gem 'spork', '0.9.0'
end

gem 'dynamic_form'
gem 'haml'
gem 'mercury-rails'

gem 'paperclip'