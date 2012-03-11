require 'lib/lastfm_path_finder'

describe LastfmPathFinder::Path do 

  it "should be marked as not found before the path is found" do

    from = LastfmPathFinder::Artist.new(:name => "from")
    to = LastfmPathFinder::Artist.new(:name => "to")
    
    path = LastfmPathFinder::Path.new from, to
    path.should_not be_path_found

  end  

end