class ChessGame < ActiveRecord::Base

  RESULTS = [nil, '1-0','1/2','0-1', '*']

  validates :white_player, presence: true
  validates :black_player, presence: true
  validates :result, presence: true, inclusion: (1..RESULTS.length)

  has_one :white_player, class_name: 'Player', primary_key: :white_player_id,  foreign_key: :id
  has_one :black_player, class_name: 'Player', primary_key: :black_player_id,  foreign_key: :id
  has_many :chess_moves, dependent: :destroy
  belongs_to :round

  after_save :refresh_tournament_results

  def chess_result
    RESULTS[self.result] || "?"
  end

  def all_moves
    chess_moves.map(&:get_move_string).flatten
  end

  def all_moves_reversed
    reverse_move_notation(all_moves)
  end

  private

  def reverse_move_notation(all_moves)
    all_moves.map{|m| reverse_move(m)}
  end

  def reverse_move(move_notation)
    "#{move_notation[3..4]}-#{move_notation[0..1]}"
  end

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
