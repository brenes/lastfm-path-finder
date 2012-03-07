require 'lib/lastfm_path_finder'
describe LastfmPathFinder::Artist do 
  
  it "gets data for existing artists from Last.FM" do
    artist = LastfmPathFinder::Artist.find_in_lastfm "pink floyd"
    artist.should_not be_nil
    artist.id.should be_eql("pink-floyd")
    artist.name.should == "Pink Floyd"
  end  

  it "handles non-existing artists when retrieving info from Last.FM" do
    artist = LastfmPathFinder::Artist.find_in_lastfm "who is pink?"
    artist.should be_nil
  end

end