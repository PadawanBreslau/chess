require 'spec_helper'

describe Game do
  context 'creating game' do
  	it 'should create simple game' do 
	  	FactoryGirl.build(:game).should be_valid
	  	FactoryGirl.build(:game_with_players).should be_valid
	  end

	  it 'should not create game without any of the players' do
	  	FactoryGirl.build(:game_with_players, white_player: nil).should_not be_valid
	  	FactoryGirl.build(:game_with_players, black_player: nil).should_not be_valid
	  end

	  it 'should not create game without result or with improper valuse' do
	  	FactoryGirl.build(:game).should be_valid
	  	FactoryGirl.build(:game, result: nil).should_not be_valid
	  	FactoryGirl.build(:game, result: 1).should be_valid
	  	FactoryGirl.build(:game, result: 99).should_not be_valid
	  end

	  it 'should return chess result as string' do
	  	FactoryGirl.build(:game, result: 1).chess_result.should eql "1-0"
	  	FactoryGirl.build(:game, result: 2).chess_result.should eql "1/2"
	  	FactoryGirl.build(:game, result: 3).chess_result.should eql "0-1"
			FactoryGirl.build(:game, result: 4).chess_result.should eql "*"
	  end


  end
end