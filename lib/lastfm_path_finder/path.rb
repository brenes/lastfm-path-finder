class LastfmPathFinder::Path

  include Redis::Objects
  
  attr_accessor :id
  attr_accessor :artist_from, :artist_to

  list :artists

  def initialize from, to
    self.artist_from = from
    self.artist_to = to
    self.id = "#{artist_from.id}_#{artist_to.id}"
  end

  def path_found?
    !artists.blank?
  end

  
end