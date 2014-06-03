class Statistic < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :value, presence: true

  def to_hash
    value.gsub(/[{}:]/,'').split(', ').map{|h| h1,h2 = h.split('=>'); {h1 => h2}}.reduce(:merge)
  end

  def self.generate_players_statistics
    ActiveRecord::Base.transaction do
      Player.get_players_titles
      Player.get_players_ratings
      Player.get_games_number
      Player.get_countries
      ST_LOG.info "Finished generating statistics"
    end
  end

end
