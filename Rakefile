# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "lastfm-path-finder"
  gem.homepage = "http://github.com/brenes/lastfm-path-finder"
  gem.license = "MIT"
  gem.summary = %Q{TODO: Finding paths between artists in Lastfm since 1888}
  gem.description = %Q{TODO: gem for finding paths between artists in Last.fm}
  gem.email = "davidjbrenes@gmail.com"
  gem.authors = ["David J. Brenes"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec