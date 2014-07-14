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
      ST_LOG.info "Finished generating statistics for players"
    end
  end

  def self.generate_users_statistics
    ActiveRecord::Base.transaction do
      SiteUser.get_user_countries
      SiteUser.get_users_comments
      SiteUser.get_user_ratings
      SiteUser.get_user_birthdays
      SiteUser.get_user_reputations
      ST_LOG.info "Finished generating statistics for users"
    end
  end

end
