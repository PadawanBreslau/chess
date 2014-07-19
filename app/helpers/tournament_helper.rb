require 'active_support/concern'
require 'pgn_parser'

module TournamentHelper
  extend ActiveSupport::Concern

  RESULTS = [nil, '1-0','1/2','0-1', '*']

  def parse_and_insert_from_pgn(pgn_file)
    pgn_content = PgnFileContent.new(pgn_file.read)
    parsed_content = pgn_content.parse_games
    parsed_content.each do |one_game|
      raise "Should be a ByzantionChess::Game class" unless one_game.kind_of?(Game)
      header = one_game.header
      white_player = Player.find_or_create_player_by_string(header["White"])
      black_player = Player.find_or_create_player_by_string(header["Black"])
      result = RESULTS.index(header["Result"])
      round = find_or_create_round(header["Round"])
      game = ChessGame.new()
      debugger
      puts 'a'
    end

  end

  private

  def find_or_create_round(round_description)
  end

end
