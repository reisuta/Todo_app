source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt'
gem 'pg', '~> 1.1'
gem 'pry-rails', '~> 0.3.9'
#
# gem 'image_processing', '~> 1.2'

gem 'rails-i18n', '~> 6.0'
gem 'enum_help', '~> 0.0.17'
gem 'ransack', '~> 2.4', '>= 2.4.2'
gem 'capybara', '~> 3.36'
gem 'kaminari', :git => 'https://github.com/kaminari/kaminari'
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'jquery-rails', '~> 4.4'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'jquery-turbolinks'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', '~> 2.6'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring', '~> 3.1', '>= 3.1.1'
  gem 'spring-commands-rspec', '~> 1.0', '>= 1.0.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
