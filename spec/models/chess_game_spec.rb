require 'spec_helper'

describe Game do
  context 'creating game' do
    it 'should create simple game' do
      FactoryGirl.build(:chess_game).should be_valid
      FactoryGirl.build(:chess_game_with_players).should be_valid
      expect{@game = FactoryGirl.create(:chess_game_with_players)}.not_to raise_error
      @game.white_player.should_not be_nil
    end

    it 'should not create game without any of the players' do
      FactoryGirl.build(:chess_game_with_players, white_player: nil).should_not be_valid
      FactoryGirl.build(:chess_game_with_players, black_player: nil).should_not be_valid
    end

    it 'should not create game without result or with improper valuse' do
      FactoryGirl.build(:chess_game).should be_valid
      FactoryGirl.build(:chess_game, result: nil).should_not be_valid
      FactoryGirl.build(:chess_game, result: 1).should be_valid
      FactoryGirl.build(:chess_game, result: 99).should_not be_valid
    end

    it 'should be valid with or without round id' do
      FactoryGirl.build(:chess_game).should be_valid
      FactoryGirl.build(:chess_game, round_id: 111).should be_valid
    end

    it 'should return chess result as string' do
      FactoryGirl.build(:chess_game, result: 1).chess_result.should eql "1-0"
      FactoryGirl.build(:chess_game, result: 2).chess_result.should eql "1/2"
      FactoryGirl.build(:chess_game, result: 3).chess_result.should eql "0-1"
      FactoryGirl.build(:chess_game, result: 4).chess_result.should eql "*"
    end

    it 'game should know the players in it' do
      game = FactoryGirl.create(:chess_game_with_players)
      game.white_player.should_not be_nil
      game.black_player.should_not be_nil
      game.white_player.surname.should eql "Amerigo"
      game.black_player.surname.should eql "Beowulf"
    end
  end

  context 'board methods' do
    before do
      @game = FactoryGirl.create(:chess_game)
      @move1 =  FactoryGirl.create(:chess_move, move_number: 1, chess_game_id: @game.id, fen_before: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', fen_after: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', move_notation: 'e2-e4')
      @move2 =  FactoryGirl.create(:chess_move, move_number: 1, chess_game_id: @game.id, fen_before: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', fen_after: 'rnbqkbnr/pppp1ppp/4p3/8/4P3/8/PPPP1PPP/RNBQKBNR', move_notation: 'e7-e6')
    end

    it 'should return all moves' do
      @game.all_moves.should eql ['e2-e4', 'e7-e6']

    end


    it 'should return all after move fens' do
      @game.all_after_move_fens.should eql ['rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR','rnbqkbnr/pppp1ppp/4p3/8/4P3/8/PPPP1PPP/RNBQKBNR']
    end

    it 'should return all before move fens' do
      @game.all_before_move_fens.should eql ['rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR','rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR']
    end

  end
end
