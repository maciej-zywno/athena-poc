source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '5.0.0.beta3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'athena_health', '~> 0.8.3'
gem 'font-awesome-rails'
gem 'gretel'
gem 'twilio-ruby'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

gem 'bootstrap-sass'
gem 'devise', github: 'plataformatec/devise', branch: 'master'
gem 'devise_invitable', github: 'scambra/devise_invitable'
gem 'figaro'
gem 'haml-rails'
gem 'high_voltage', github: 'thoughtbot/high_voltage'

gem 'pg'
gem 'pundit'
gem 'simple_form'
gem 'upmin-admin'
gem 'kaminari', github: 'amatsuda/kaminari'

group :development do
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
  gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
end
  gem 'rubocop'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

# alexa
gem 'alexa_verifier'
gem 'alexa_rubykit'

# alchemy
gem 'alchemy-api-rb', require: 'alchemy_api'

# charts
gem 'chartjs-ror'

gem 'sidekiq', branch: 'rails5'
gem 'sidekiq-failures'
gem 'sinatra', github: 'sinatra/sinatra'
gem 'raygun4ruby'
gem 'doorkeeper', github: 'doorkeeper-gem/doorkeeper'
