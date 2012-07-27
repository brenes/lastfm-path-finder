class LastfmPathFinder::Path

  include Redis::Objects

  attr_accessor :id
  attr_accessor :artist_from, :artist_to

  list :artists
  value :score

  def initialize from, to
    self.artist_from = from
    self.artist_to = to
    self.id = "#{artist_from.id}_#{artist_to.id}"
  end

  def found?
    !artists.blank?
  end


end