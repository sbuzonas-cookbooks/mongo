# -*- mode: ruby -*-
source 'https://rubygems.org'

gem 'rake'

group :style do
  gem 'foodcritic', '~> 9.0'
  gem 'rubocop', '~> 0.47.1'
end

group :unit do
  gem 'chefspec', '~> 6.1.0'
end

group :integration do
  gem 'berkshelf', '~> 5.6.3'
  gem 'kitchen-inspec', '~> 0.17'
  gem 'test-kitchen', '~> 1.16'
end

group :vagrant do
  gem 'kitchen-vagrant', '~> 1.0.2'
  gem 'vagrant-wrapper', '~> 2.0.3'
end

group :docker do
  gem 'kitchen-docker', '~> 2.6.0'
end

group :publish do
  gem 'stove', '~> 4.1.1'
end
