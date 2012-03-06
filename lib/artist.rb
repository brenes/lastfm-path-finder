require 'lib/settings'

class Artist

  attr_accessor :name

  def initialize params
    self.name = params["name"] || params[:name]
  end
  
  def self.find_in_lastfm name
    Artist.new Settings.lastfm.artist.get_info(name)
  end

end