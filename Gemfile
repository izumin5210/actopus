source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.2.0'

group :default do
  gem 'rails', '4.2.0'
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.1.0'

  gem 'devise'
  gem 'devise_invitable'
  gem 'friendly_id'
  gem 'by_star'

  gem 'garage', github: 'cookpad/garage'
  gem 'rack-json_schema'

  gem 'nokogiri'
  gem 'sax-machine'
  gem 'rails_config'

  gem 'font-awesome-helper'
  gem 'active_decorator'

  gem 'rails-assets-bootstrap-sass-official'
  gem 'rails-assets-font-awesome'

  gem 'enum_help'
end

group :staging do
  gem 'pg'
  gem 'rails_12factor'
end

group :test, :development do
  gem 'sqlite3'
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'ffaker'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'

  gem 'web-console'
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'quiet_assets'
  gem 'rails_best_practices'
  gem 'did_you_mean'
  gem 'xray-rails'

  gem 'annotate'
  gem 'letter_opener_web'

  gem 'prmd'
  gem 'jdoc'
end

group :test do
  gem 'rspec-rails'
  gem 'database_rewinder'
  gem 'shoulda-matchers', require: false
  gem 'rspec-parameterized'
  gem 'rspec-validator_spec_helper'
  gem 'rspec-request_describer'
  gem 'rspec-json_matcher'
  gem 'rspec-power_assert'
  gem 'timecop'

  gem 'coveralls', :require => false
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end
