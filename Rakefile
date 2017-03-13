# -*- mode: ruby -*-
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

Kitchen.logger = Kitchen.default_file_logger

def kitchen_config(config_file)
  if config_file.nil?
    Kitchen::Config.new
  else
    @loader = Kitchen::Loader::YAML.new(project_config: config_file)
    Kitchen::Config.new(loader: @loader)
  end
end

def kitchen_instances(config_file)
  kitchen_config(config_file).instances
end

def kitchen_test(config_file)
  instances = kitchen_instances(config_file)

  if ENV['KITCHEN_SUITE']
    instances.get(ENV['KITCHEN_SUITE']).verify
  else
    instances.each do |instance|
      instance.test(:always)
    end
  end
end

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

namespace :test do
  desc 'Run ChefSpec unit tests'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color --format progress'
  end

  namespace :integration do
    desc 'Run Test Kitchen with Vagrant'
    task :vagrant do
      kitchen_test
    end

    desc 'Run Test Kitchen with Docker'
    task :docker do
      kitchen_test('.kitchen.docker.yml')
    end

    namespace :cleanup do
      desc 'Destroy all Docker based Test Kitchen nodes'
      task :docker do
        kitchen_instances('.kitchen.docker.yml').each(&:destroy)
      end

      desc 'Destroy all Vagrant based Test Kitchen nodes'
      task :vagrant do
        kitchen_instances.each(&:destroy)
      end
    end
  end
end

desc 'Run all tests with Docker'
task docker: %w(style test:unit test:integration:docker)

desc 'Run all tests with Vagrant'
task vagrant: %w(style test:unit test:integration:vagrant)

task default: 'vagrant'
