class ChessGame < ActiveRecord::Base

  RESULTS = [nil, '1-0','1/2','0-1', '*']

  validates :white_player, presence: true
  validates :black_player, presence: true
  validates :result, presence: true, inclusion: (1..RESULTS.length)

  has_one :white_player, class_name: 'Player', primary_key: :white_player_id,  foreign_key: :id
  has_one :black_player, class_name: 'Player', primary_key: :black_player_id,  foreign_key: :id
  has_many :chess_moves, dependent: :destroy
  has_many :site_comments, as: :commentable, dependent: :destroy
  has_many :commentaries, through: :chess_moves
  belongs_to :round
  belongs_to :commentable

  after_save :refresh_tournament_results

  def to_s
    white_player.to_name + ' - ' + black_player.to_name
  end

  def chess_result
    RESULTS[self.result] || "?"
  end

  def all_moves
    chess_moves.map(&:get_move_string).flatten
  end

  def move_count
    (chess_moves.count * 0.5).ceil
  end

  def all_after_move_fens
    chess_moves.map(&:fen_after)
  end

  def all_before_move_fens
    chess_moves.map(&:fen_before)
  end

  private

  def refresh_tournament_results
    RES_LOG.info "Refreshing tournament results after save: #{self.inspect}"
    tournament = round.tournament
    tournament.recalculate_all_results
  rescue NoMethodError => e
    ER_LOG.error e.backtrace
    ER_LOG.error e.message
    ER_LOG.info "Game without tournament or round. Unable to create results"
  rescue StandardError => e
    ER_LOG.error e.backtrace
    ER_LOG.error e.message
  end
end
