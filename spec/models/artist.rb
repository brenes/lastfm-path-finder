require 'rubygems'
require "bundler/setup"
require 'lib/artist'
describe Artist do 
  
  it "gets data for existing artists from Last.FM" do
    artist = Artist.find_in_lastfm "pink floyd"
    artist.should_not be_nil
    artist.name.should be_eql("Pink Floyd")
  end  

end