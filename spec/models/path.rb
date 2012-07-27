require 'lib/lastfm_path_finder'

describe LastfmPathFinder::Path do

  let(:from) {LastfmPathFinder::Artist.new(:name => from_name)}
  let(:to) {LastfmPathFinder::Artist.new(:name => to_name)}
  let(:path) do
    VCR.use_cassette('lastfm', :record => :new_episodes) do
      LastfmPathFinder::Finder.find from, to
    end
  end

  context "when there's a direct path between artists" do

    let(:from_name) {"Pink Floyd"}
    let(:to_name) {"David Gilmour"}

    subject { path }
    it { should be_found }
    it { path.artists.count.should be_eql(2) }

  end

  context "when two artists share a common related artist" do

    let(:from_name) {"Pink Floyd"}
    let(:to_name) {"B.B. King & Eric Clapton"}

    subject { path }
    it { should be_found }
    it { path.artists.count.should be_eql(3) }
    it { path.artists.values.should == (["Pink Floyd","Eric Clapton","B.B. King & Eric Clapton"]) }

  end

end