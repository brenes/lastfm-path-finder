require 'lib/lastfm_path_finder'

describe LastfmPathFinder::Path do

  context "when there's a direct path between artists" do

    let(:from) {LastfmPathFinder::Artist.new(:name => "Pink Floyd")}
    let(:to) {LastfmPathFinder::Artist.new(:name => "David Gilmour")}
    let(:path) do
      VCR.use_cassette('lastfm', :record => :new_episodes) do
        LastfmPathFinder::Finder.find from, to
      end
    end

    subject { path }
    it { should be_found }
    it { path.artists.count.should be_eql(2) }

  end

  context "when two artists share a common related artist" do

    let(:from) {LastfmPathFinder::Artist.new(:name => "Pink Floyd")}
    let(:to) {LastfmPathFinder::Artist.new(:name => "B.B. King & Eric Clapton")}
    let(:path) do
      VCR.use_cassette('lastfm', :record => :new_episodes) do
        LastfmPathFinder::Finder.find from, to
      end
    end

    subject { path }
    it { should be_found }
    it { path.artists.count.should be_eql(3) }
    it { path.artists.values.should == (["Pink Floyd","Eric Clapton","B.B. King & Eric Clapton"]) }

  end

end