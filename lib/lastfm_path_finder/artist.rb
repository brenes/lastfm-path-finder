require 'active_support/core_ext'
class LastfmPathFinder::Artist

  include Redis::Objects
  
  attr_accessor :id

  value :name
  sorted_set :related_artists

  def initialize params  
    self.id = (params["name"] || params[:name]).parameterize
    self.name = params["name"] || params[:name]  
  end

  alias_method :related_artists_without_lastfm, :related_artists

  def related_artists
    related = related_artists_without_lastfm
    related.blank? ? related_artists_in_lastfm : related
  end
    
  def related_artists_in_lastfm
    artists = LastfmPathFinder::Settings.lastfm_api.artist.get_similar(self.name)
    artists.each do |artist|
      related_artists_without_lastfm[artist["name"]] = artist["match"]
    end
    related_artists_without_lastfm
  end

  def self.find_in_lastfm name
    begin
      LastfmPathFinder::Artist.new(LastfmPathFinder::Settings.lastfm_api.artist.get_info(name))
    rescue Lastfm::ApiError => e    
      nil  
    end
    
  end

end