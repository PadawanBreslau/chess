# -*- encoding : utf-8 -*-
require 'spec_helper'


describe Round do
  context 'creating rounds' do
    it 'should create empty round' do
      FactoryGirl.build(:round).should be_valid
      FactoryGirl.build(:round, date: nil).should be_valid
    end

    it 'should create round with games and players' do
      games = []
      5.times do
        games << FactoryGirl.create(:game_with_random_players)
      end
      (round = FactoryGirl.build(:round_with_games)).should be_valid
      round.games.should be_empty
      (round = FactoryGirl.create(:round)).should be_valid
      round.games = games
      round.games.should_not be_empty
      round.games.count.should eql 5

      round.games.each do |game|
        game.white_player.should_not be_nil
        game.white_player.should_not be_nil
      end
    end
  end
end