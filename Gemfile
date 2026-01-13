source "https://rubygems.org"

gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.2"

gem "solid_cable"
gem "solid_cache"
gem "solid_queue"

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: [:mri, :windows], require: "debug/prelude"

  gem "csv"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"

  # Code quality
  gem "brakeman", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end
