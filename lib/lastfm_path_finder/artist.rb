require 'active_support/core_ext'
class LastfmPathFinder::Artist

  include Redis::Objects
  
  attr_accessor :id

  value :name

  def initialize params
    self.id = params["id"] || params[:id]
    self.name = params["name"] || params[:name]
  end

  def self.find_in_lastfm name
    begin
      LastfmPathFinder::Artist.new({:id => name.parameterize}.merge(LastfmPathFinder::Settings.lastfm_api.artist.get_info(name)))
    rescue Lastfm::ApiError => e    
      nil  
    end
    
  end

end