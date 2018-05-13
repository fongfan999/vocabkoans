source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails', '~> 2.4'
gem 'ice_nine', '~> 0.11.2', require: ['ice_nine', 'ice_nine/core_ext/object']

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'mina', require: false
  gem 'mina-puma', require: false,  github: 'untitledkingdom/mina-puma'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'facebook-messenger', '~> 1.0'
gem 'sidekiq', '~> 5.1.3'
gem 'whenever', '~> 0.10.0', require: false
