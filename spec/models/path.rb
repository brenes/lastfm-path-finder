require 'lib/lastfm_path_finder'

describe LastfmPathFinder::Path do

  describe "when there's no path" do

    let(:from) {LastfmPathFinder::Artist.new(:name => "from")}
    let(:to) {LastfmPathFinder::Artist.new(:name => "to")}
    let(:path) do
      VCR.use_cassette('lastfm', :record => :new_episodes) do
        LastfmPathFinder::Finder.find from, to
      end
    end

    subject { path }
    it { should_not be_found }

  end

  context "when there's path" do

    let(:from) {LastfmPathFinder::Artist.new(:name => "Pink Floyd")}
    let(:to) {LastfmPathFinder::Artist.new(:name => "David Gilmour")}
    let(:path) do
      VCR.use_cassette('lastfm', :record => :new_episodes) do
        LastfmPathFinder::Finder.find from, to
      end
    end

    subject { path }
    it { should be_found }

  end

end