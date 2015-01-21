require 'active_support/concern'

module PlayerHelper
  extend ActiveSupport::Concern

  def self.format_rating_output(rating, year, month)
    "#{rating} (#{year}-#{Date::ABBR_MONTHNAMES[month]})"
  end

  def get_highest_rating
    fide_ratings.sort{|x,y| y.rating <=> x.rating}.first
  end

  def get_lowest_rating
    fide_ratings.sort{|x,y| x.rating <=> y.rating}.first
  end

  def get_current_rating
    fide_ratings.sort_by{|r| [r.year, r.month]}.last
  end

  def get_player_ratings
    ratings = {}
    fide_ratings.each do |rating|
      ratings["#{rating.year}/#{rating.month}"] = rating.rating
    end
    ratings
  end

  def get_player_colors
    {"white" => white_games.count, "black" => black_games.count}
  end

  def get_player_results(colour)
    results = Hash.new(0)
    if colour == 'white'
      white_games.each do |wgame|
        results["White wins"] += 1 if wgame.result == 1
        results["White draws"] += 1 if wgame.result == 2
        results["White loses"] += 1 if wgame.result == 3
      end
    elsif colour == 'black'
      black_games.each do |bgame|
        results["Black loses"] += 1 if bgame.result == 1
        results["Black draws"] += 1 if bgame.result == 2
        results["Black wins"] += 1 if bgame.result == 3
      end
    end
    results
  end

  def get_player_activities
    games = Hash.new
    fide_ratings.each do |rating|
      games["#{rating.year}/#{rating.month}"] = rating.games
    end
    games
  end

  module ClassMethods

    def find_or_create_player_by_string(player_string)
      begin
        surname, name = player_string.split(',').map(&:strip)
        players_with_surname = Player.where(surname: surname, name: name).load
        TOUR_LOG.info "Looking for player: #{surname}, #{name}"
        return players_with_surname.first if players_with_surname.size == 1
        #players_with_name_and_surname = players_with_surname.select{|player| player.name == name}
        #return players_with_name_and_surname.first if players_with_name_and_surname.size == 1
        TOUR_LOG.info "Player not found. Creating new"
        Player.create(name: name, surname: surname)
      rescue StandardError => e
        ER_LOG.info "Problem with find_or_create player"
        ER_LOG.info e.message
      end
    end

    def get_players_titles
      Statistic.find_by_name('players_titles').try(:destroy)
      mappings = {"GM" => "Grandmaster", "IM" => "International Master", "WGM" => "Women Grandmaster", "WIM" => "Women International Master", "FM" => "Fide Master", "WFM" => "Women Fide Master", "CM" => "Candidate for Master", "WCM" => "Women Candidate for Master", nil => "No title"}
      players_titles = Player.all.map{|pl| pl.try(:title)}.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
      value = Hash[players_titles.map {|k, v| [mappings[k], v] }]
      Statistic.create!(name: 'players_titles', value: value.inspect)
    end

    def get_players_ratings
      Statistic.find_by_name('players_ratings').try(:destroy)
      rating_result = Hash.new
      players_ratings = Player.all.map{|pl| pl.get_current_rating.try(:rating)}
      rating_result["No known rating"] = players_ratings.size - players_ratings.compact!.size
      (0..9).each do |n|
        rating_result["#{1000+(n*200)}-#{1200+(n*200)}"] =
    players_ratings.select{|rank| rank >= 1000+(n*200) && rank < 1200+(n*200) }.count
      end
      Statistic.create!(name: 'players_ratings', value: rating_result.inspect)
    end

    def get_games_number
      Statistic.find_by_name('games_number').try(:destroy)
      games_result = Hash.new
      players_games = Player.all.map{|pl| pl.chess_games.count}
      (0..9).each do |n|
        games_result["#{n*20}-#{(n+1)*20}"] =
        players_games.select{|games| games >= (n*20) && games < (n+1)*20 }.count
      end
      games_result["200+"] = players_games.select{|games| games > 200}
      Statistic.create!(name: 'games_number', value: games_result.inspect)
    end

    def get_countries
      Statistic.find_by_name('players_countries').try(:destroy)
      players_countries_short = Player.group(:country_code).count.select{ |_,v| v > Player.count/200 }
      players_countries = Hash[players_countries_short.map {|k, v| [Country.find_country_by_alpha3(k).try(:name), v] }]
      Statistic.create!(name: 'players_countries', value: players_countries.inspect)
    end

  end
end
