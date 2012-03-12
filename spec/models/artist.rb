require 'lib/lastfm_path_finder'

require 'vcr'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock # or :fakeweb
end

describe LastfmPathFinder::Artist do 

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
      related.members(:with_scores => true).last[0].should be_eql("David Gilmour")
      related.members(:with_scores => true).last[1].should be_eql(1.0)
      related.members(:with_scores => true)[-2][0].should be_eql("Roger Waters")
      related.members(:with_scores => true)[-2][1].should be_eql(0.778598)
    end

  end


end