class LastfmPathFinder::Finder

  # This method finds a way between the two artists. How?
  # 0) We ensure that we don't already have a path for these artists
  # 1) We get the related to From
  # 2) We check if To is in this related list
  # 3) If it's not, we get the related to To
  # 4) We check if From is in this list
  # 5) We check if both related lists share (at least, one artist)
  # 6) We update the score tables and try in a recursive way to find a way between any pair of nodes of the relateds lists
  def self.find from, to, currently_included = []

    # 0)
    path = LastfmPathFinder::Path.new from, to
    return path unless path.artists.blank?

    currently_included.push from
    currently_included.push to

    # 1)
    related_from = from.related_artists

    # 2)
    if related_from.member?(to.name.value)
      score = related_from.score(to.name.value)
      path = LastfmPathFinder::Path.new from, to
      path.score = score
      path.artists << from.name.value
      path.artists << to.name.value
      return path
    end

    # 3)
    related_to = to.related_artists

    # 4)
    if related_from.member?(from.name.value)
      score = related_to.score(from.name.value)
      path = LastfmPathFinder::Path.new from, to
      path.score = score
      path.artists << from.name.value
      path.artists << to.name.value
      return path
    end

    # 5)
    related_from_members = related_from.members
    related_to_members = related_to.members

    # We create an array of shared relates were we are gonna insert those artists present on both lists
    # with an score wquals to the product of both scores, so we can find the most related to both artists
    shared_relate = []
    related_from_members.each do |name|

      score = related_from.score(name)
      other_score = related_to.score(name)
      unless other_score.nil?
        shared_relate << {:name => name, :score => score*other_score}
      end

    end

    # Now we get the first one and return a path with these three nodes
    unless shared_relate.blank?
      shared_contact = shared_relate.sort_by{|r|r[:score]}.first

      path = LastfmPathFinder::Path.new from, to
      path.score = shared_contact[:score]

      path.artists << from.name.value
      path.artists << shared_contact[:name]
      path.artists << to.name.value

      return path
    end

    #6)

    # We store the artists for the score
    related_from_members.reverse!
    related_to_members.reverse!

    related_from_members.each do |from_name|

      from_score = related_from.score(from_name)

      related_to_members.each do |to_name|

        to_score = related_to.score(to_name)

        path = self.find(LastfmPathFinder::Artist.new(:name => r_from), LastfmPathFinder::Artist.new(:name => r_to))

        unless path.nil?
          new_path = LastfmPathFinder::Path.new from, to
          new_path.score = path.score * from_score * to_score
          new_path.artists << from.name
          path.artists.each {|a| new_path.artists << a }
          new_path.artists << to.name
          return new_path
        end

      end
    end

    path

  end

end