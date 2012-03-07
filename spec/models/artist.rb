require 'lib/lastfm_path_finder'
describe LastfmPathFinder::Artist do 
  
  it "gets data for existing artists from Last.FM" do
    artist = LastfmPathFinder::Artist.find_in_lastfm "pink floyd"
    artist.should_not be_nil
    artist.name.should be_eql("Pink Floyd")
    artist.id.should be_eql("pink-floyd")
  end  

  it "handles non-existing artists when retrieving info from Last.FM" do
    artist = LastfmPathFinder::Artist.find_in_lastfm "who is pink?"
    artist.should be_nil
  end

end