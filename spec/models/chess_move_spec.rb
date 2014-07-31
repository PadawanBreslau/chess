require 'spec_helper'

describe ChessMove do
  context 'creating move' do
    before do
      @game = FactoryGirl.create(:chess_game)
    end

    it 'should create simple game' do
      expect{FactoryGirl.create(:chess_move, move_number: 1, chess_game_id: @game.id, fen_before: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', fen_after: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', move_notation: 'e2-e4')}.to change(ChessMove, :count).from(0).to(1)
    end

    it 'should now the next_move' do
      @move1 =  FactoryGirl.create(:chess_move, move_number: 1, chess_game_id: @game.id, fen_before: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', fen_after: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', move_notation: 'e2-e4')
      @move2 =  FactoryGirl.create(:chess_move, move_number: 1, chess_game_id: @game.id, fen_before: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', fen_after: 'rnbqkbnr/pppp1ppp/4p3/8/4P3/8/PPPP1PPP/RNBQKBNR', move_notation: 'e7-e6')

      @move1.next_move.should eql @move2

    end
  end
end
