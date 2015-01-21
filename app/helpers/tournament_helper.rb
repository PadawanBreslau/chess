require 'active_support/concern'
require 'pgn_parser'
require 'byzantion_chess'

module TournamentHelper
  extend ActiveSupport::Concern

  RESULTS = [nil, '1-0','1/2','0-1', '*']

  def map_result(result)
    return 2 if result == '1/2-1/2'
    RESULTS.index(result)
  end

  def parse_and_insert_from_pgn(pgn_file)
    @players = Hash.new
    begin
      clear_file = pgn_file.read.gsub("\r", "")
      pgn_content = PgnFileContent.new(clear_file, BYZ_LOG)
      parsed_content = pgn_content.parse_games
      ST_LOG.info "Parsed games. Games count: #{parsed_content.size}"
      parsed_content.each do |one_game|
        raise "Should be a ByzantionChess::Game class" unless one_game.kind_of?(Game)
        header = one_game.header
        ST_LOG.info "Importing game with header"
        ST_LOG.info header.inspect
        next if header["White"].nil? || header["Black"].nil? || header["Round"].nil?
        #white_player = Player.find_or_create_player_by_string(header["White"])
        #black_player = Player.find_or_create_player_by_string(header["Black"])
        white_player = Player.find_player(header["White"], @players)
        black_player = Player.find_player(header["Black"], @players)
        @players[header["White"]] = white_player
        @players[header["Black"]] = black_player

        result = map_result(header["Result"])
        round = find_or_create_round(header["Round"], header["Date"])
        ST_LOG.info "Round for a game: #{round}"
        game = ChessGame.new(white_player: white_player, black_player: black_player, white_player_id: white_player.id, black_player_id: black_player.id, result: result, round: round)
        add_moves_to_game(game, one_game.moves)
      end
    rescue StandardError => e
      ER_LOG.info e.backtrace.join("\n")
      ER_LOG.info e.message
      ER_LOG.info "Problem with importing games from PGN file"
    end
  end

  def find_or_create_round(round_description, date)
    number = round_description.split('.').first.to_i
    matching_rounds = rounds.select{|r| r.round_number == number}
    return matching_rounds.first if matching_rounds.size == 1
    round = Round.create!(tournament: self, round_number: number, date: date.to_datetime) and self.reload
    return round
  end

  def add_moves_to_game(game, moves)
    # TODO - only main game. Also - move number
    begin
      board = ByzantionChess::Board.new
      moves["0"].each do |move|
        fen_before = board.writeFEN
        piece = board.piece_from(move.to_s[0..1]).to_s
        move.execute(board)
        fen_after = board.writeFEN
        ChessMove.create!(move_notation: move.to_s, level: 0, chess_game: game, fen_before: fen_before, fen_after: fen_after, piece: piece)
      end
    rescue StandardError => e
      ER_LOG.info e.message
      ER_LOG.info e.backtrace
      fail
    end
  end

end
