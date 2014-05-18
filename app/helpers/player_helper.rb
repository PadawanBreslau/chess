require 'active_support/concern'

module PlayerHelper
  extend ActiveSupport::Concern

  def self.format_rating_output(rating, year, month)
    "#{rating} (#{year}-#{Date::ABBR_MONTHNAMES[month]})"
  end

  def get_highest_rating
    highest = fide_ratings.sort{|x,y| y.rating <=> x.rating}.first
  end

  def get_current_rating
    current = fide_ratings.sort_by{|r| [r.year, r.month]}.last
  end

  module ClassMethods

    def get_players_titles
      mappings = {"GM" => "Grandmaster", "IM" => "International Master", "WGM" => "Women Grandmaster", "WIM" => "Women International Master", "FM" => "Fide Master", "WFM" => "Women Fide Master", "CM" => "Candidate for Master", "WCM" => "Women Candidate for Master", nil => "No title"}
      players_titles = Player.all.map{|pl| pl.try(:title)}.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
      Hash[players_titles.map {|k, v| [mappings[k], v] }]
    end

    def get_players_ratings
      rating_result = Hash.new
      players_ratings = Player.all.map{|pl| pl.get_current_rating.try(:rating)}
      rating_result["No known rating"] = players_ratings.size - players_ratings.compact!.size
      (0..9).each do |n|
        rating_result["#{1000+(n*200)}-#{1200+(n*200)}"] =
    players_ratings.select{|rank| rank >= 1000+(n*200) && rank < 1200+(n*200) }.count
      end
      rating_result
    end

    def get_games_number
      games_result = Hash.new
      players_games = Player.all.map{|pl| pl.games.count}
      (0..9).each do |n|
        games_result["#{n*20}-#{(n+1)*20}"] =
        players_games.select{|games| games >= (n*20) && games < (n+1)*20 }.count
      end
      games_result["200+"] = players_games.select{|games| games > 200}
      games_result
    end

  end
end
