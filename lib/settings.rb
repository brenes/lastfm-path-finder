require 'settingslogic'
require 'lastfm'
class Settings < Settingslogic
  source "config/settings.yml"
  
  def self.lastfm
    @@lastfm ||= Lastfm.new(Settings["lastfm"]["api_key"], Settings["lastfm"]["api_secret"])
    @@lastfm
  end  
end