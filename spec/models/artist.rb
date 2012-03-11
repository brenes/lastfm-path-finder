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


end