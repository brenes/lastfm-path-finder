require 'lib/lastfm_path_finder'

describe LastfmPathFinder::Artist do

  it "should have no data when not requested to LastFM" do
    artist = LastfmPathFinder::Artist.new(:id => "pink-floyd")
    artist.name.should be_nil
  end
  it "gets data for existing artists from Last.FM" do

    VCR.use_cassette('lastfm', :record => :new_episodes) do
      artist = LastfmPathFinder::Artist.find_in_lastfm "pink floyd"
      artist.should_not be_nil
      artist.id.should be_eql("pink-floyd")
      artist.name.should == "Pink Floyd"
    end

  end  

  it "handles non-existing artists when retrieving info from Last.FM" do
    
    VCR.use_cassette('lastfm', :record => :new_episodes) do
      artist = LastfmPathFinder::Artist.find_in_lastfm "who is pink?"
      artist.should be_nil
    end
    
  end

  it "gets data about related artists on LastFM" do

    VCR.use_cassette('lastfm', :record => :new_episodes) do
      artist = LastfmPathFinder::Artist.new :name => "pink floyd"
      related = artist.related_artists
      related.should_not be_nil

      related.members.last.should be_eql("David Gilmour")
      related.score("David Gilmour").should be_eql(1.0)
      related.members[-2].should be_eql("Roger Waters")
      related.score("Roger Waters").should be_eql(0.778598)
    end

  end


end