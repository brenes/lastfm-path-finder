require 'settingslogic'
require 'lastfm'
class LastfmPathFinder::Settings < Settingslogic
  source "config/settings.yml"
  
  def self.lastfm_api
    @@lastfm ||= Lastfm.new(LastfmPathFinder::Settings["lastfm"]["api_key"], LastfmPathFinder::Settings["lastfm"]["api_secret"])
    @@lastfm
  end  
end