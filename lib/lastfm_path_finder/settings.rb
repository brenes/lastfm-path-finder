require 'settingslogic'
require 'lastfm'

class LastfmPathFinder::Settings < Settingslogic
  source "config/settings.yml"
  
  def self.lastfm_api
    @@lastfm ||= Lastfm.new(self["lastfm"]["api_key"], self["lastfm"]["api_secret"])
  end  

  def self.redis_connection
    Redis.current ||= Redis.new self["redis"]
  end
end