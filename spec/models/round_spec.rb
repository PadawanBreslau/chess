# -*- encoding : utf-8 -*-
require 'spec_helper'


describe Round do
  context 'creating rounds' do
    it 'should create empty round' do
      FactoryGirl.build(:round).should be_valid
      FactoryGirl.build(:round, date: nil).should be_valid
    end

    it 'should have no players when it has no games' do
      FactoryGirl.create(:round).players.should be_empty
    end

    # it 'should have players when it has games' do
    #   games = []
    #   round = FactoryGirl.create(:round)
    #   5.times do
    #     games << FactoryGirl.create(:chess_game_with_random_players)
    #   end
    #   round.games = games
    #   players = round.players
    #   round.games.each do |game|
    #     players.should include game.white_player
    #     players.should include game.black_player
    #   end
    # end

    it 'should create round with games and players' do
      games = []
      5.times do
        games << FactoryGirl.create(:chess_game_with_random_players)
      end
      (round = FactoryGirl.build(:round_with_games)).should be_valid
      round.chess_games.should be_empty
      (round = FactoryGirl.create(:round)).should be_valid
      round.chess_games = games
      round.chess_games.should_not be_empty
      round.chess_games.count.should eql 5

      round.chess_games.each do |game|
        game.white_player.should_not be_nil
        game.black_player.should_not be_nil
      end
    end
  end
end
