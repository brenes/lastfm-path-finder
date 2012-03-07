module LastfmPathFinder
  require 'rubygems'
  require "bundler/setup"
  require 'lastfm'
  require 'redis'
  require 'redis/objects'

  require 'lastfm_path_finder/settings'
  Settings.redis_connection
  require 'lastfm_path_finder/artist'
end