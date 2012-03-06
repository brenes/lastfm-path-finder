require 'lib/settings'

class Artist

  attr_accessor :name

  def initialize params
    self.name = params["name"] || params[:name]
  end

  def self.find_in_lastfm name
    
    begin
      Artist.new Settings.lastfm_api.artist.get_info(name)  
    rescue Lastfm::ApiError => e    
      nil  
    end
    
  end

end