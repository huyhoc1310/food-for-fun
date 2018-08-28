source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.1"

gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.0.0"
gem "bootstrap-kaminari-views"
gem "carrierwave"
gem "chartkick"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "1.7.3"
gem "figaro"
gem "font-awesome-rails"
gem "geocoder"
gem "groupdate"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.0"
gem "rails-i18n"
gem "ratyrate"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "mysql2"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "fog", "1.42"
  gem "pg"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
