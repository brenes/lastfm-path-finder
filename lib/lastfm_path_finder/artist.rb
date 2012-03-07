require 'active_support/core_ext'

class LastfmPathFinder::Artist

  attr_accessor :name

  def id
    name.parameterize
  end

  def initialize params
    self.name = params["name"] || params[:name]
  end

  def self.find_in_lastfm name
    
    begin
      LastfmPathFinder::Artist.new LastfmPathFinder::Settings.lastfm_api.artist.get_info(name)  
    rescue Lastfm::ApiError => e    
      nil  
    end
    
  end

end