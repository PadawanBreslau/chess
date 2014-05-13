module PlayerHelper

  def self.format_rating_output(rating, year, month)
    "#{rating} (#{year}-#{Date::ABBR_MONTHNAMES[month]})"
  end

  def get_highest_rating
    highest = fide_ratings.sort{|x,y| y.rating <=> x.rating}.first
  end

  def get_current_rating
    current = fide_ratings.sort_by{|r| [r.year, r.month]}.last
  end

end
