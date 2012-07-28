module LastfmPathFinder
  require 'rubygems'
  require "bundler/setup"
  require 'lastfm'
  require 'redis'
  require 'redis/objects'

  require_relative 'lastfm_path_finder/settings'
  Settings.redis_connection
  require_relative 'lastfm_path_finder/artist'
  require_relative 'lastfm_path_finder/path'
  require_relative 'lastfm_path_finder/finder'
end