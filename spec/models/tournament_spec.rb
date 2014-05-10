require 'spec_helper'

describe Tournament do
  def create_game(player1, player2, round,result)
    Game.create!(white_player: player1, white_player_id: player1.id , black_player: player2, black_player_id: player2.id, round: round, result: result)
  end

  context 'creating tournaments' do
    it 'should create simple tournament' do
      FactoryGirl.build(:tournament).should be_valid
    end

    it 'should create tournament with additional informations' do
      FactoryGirl.build(:tournament, round_number: 9).should be_valid
      FactoryGirl.build(:tournament, round_number: 99).should be_valid
      FactoryGirl.build(:tournament, round_number: 1000).should_not be_valid
      FactoryGirl.build(:tournament, round_number: 0).should_not be_valid
      FactoryGirl.build(:tournament, round_number: 'a').should_not be_valid
      FactoryGirl.build(:tournament, is_finished: true).should be_valid
      FactoryGirl.build(:tournament, is_finished: false).should be_valid
      FactoryGirl.build(:tournament, place: "aaaa").should be_valid
      FactoryGirl.build(:tournament, place: 1234).should_not be_valid
      FactoryGirl.build(:tournament, external_transmition_url: "http://euro2013.chessdom.com/").should be_valid
      FactoryGirl.build(:tournament, external_transmition_url: "aaaa").should_not be_valid
      FactoryGirl.build(:tournament, external_transmition_url: 1234).should_not be_valid
      FactoryGirl.build(:tournament, url: "http://euro2013.chessdom.com/").should be_valid
      FactoryGirl.build(:tournament, url: "euro2013.chessdom.com").should be_valid
      FactoryGirl.build(:tournament, url: "euro2013chessdomcom").should_not be_valid
    end

    it 'should not create tournament with start date after finish date' do
      FactoryGirl.build(:tournament, tournament_start: Date.today, tournament_finish: Date.today - 1.day).should_not be_valid
    end

    it 'should have no players if there is no rounds' do
      @t1 = FactoryGirl.build(:tournament)
      @t1.players.should be_empty
    end
  end

  context 'creating rounds after creating or updating tournaments' do

    it 'should create tournament with proper dates' do
      expect{@t1 = FactoryGirl.create(:tournament, tournament_start: Date.today, tournament_finish: Date.today + 8.days, round_number: 9)}.not_to raise_error
      @t1.rounds.first.date.should == Date.today
      @t1.rounds.last.date.should == Date.today + 8.day
    end

    it 'should never create round when rounds are already created' do
      rounds = [FactoryGirl.create(:round)]
      expect{@t1 = FactoryGirl.create(:tournament, round_number: 9, rounds: rounds)}.not_to raise_error
      @t1.rounds.count.should eql 1
    end

    it 'should create rounds when round number is defined, but tournament has no rounds' do
      expect{@t1 = FactoryGirl.build(:tournament)}.not_to raise_error
      @t1.rounds.should be_empty
      @t2 = FactoryGirl.create(:tournament, tournament_name: "Tournament 2",  round_number: 9)
      @t2.rounds.size.should eql 9
    end
  end

  context 'tournament should have games through rounds' do
    it 'should have no games if no rounds' do
      FactoryGirl.create(:tournament).games.should be_empty
    end

    it 'should not have games if rounds present, but without games' do
      FactoryGirl.create(:tournament_with_rounds).games.should be_empty
    end

    it 'should have games if rounds present with rounds' do
      FactoryGirl.create(:tournament_with_rounds_and_games).games.should_not be_empty
    end
  end

  context 'tournament_result' do
    before do
      @tournament = FactoryGirl.create(:tournament)
      @round = FactoryGirl.create(:round, tournament: @tournament)
      @tournament.reload
      @player1 = FactoryGirl.create(:player, fide_id: 123, name: 'Andy')
      @player2= FactoryGirl.create(:player, fide_id: 321, name: 'Bert')
    end

    it 'should create a Result object after adding a Game' do
      expect{Game.create!(white_player: @player1, white_player_id: @player1.id , black_player: @player2, black_player_id: @player2.id, round: @tournament.rounds.first, result: 1)}.to change(Result, :count).from(0).to(2)
      Result.count.should eq 2
    end

    it 'should fill all data in result' do
      expect{Game.create!(white_player: @player1, white_player_id: @player1.id , black_player: @player2, black_player_id: @player2.id, round: @tournament.rounds.first, result: 1)}.not_to raise_error
      player1_result = @player1.results.first
      player2_result = @player2.results.first

      player1_result.points.should eq 1.0
      player1_result.progress.should eq 1.0
      player1_result.mini_bucholtz.should eq 0.0
      player1_result.bucholtz.should eq 0.0
      player1_result.games_count.should eq 1

      player2_result.points.should eq 0.0
      player2_result.progress.should eq 0.0
      player2_result.mini_bucholtz.should eq 0.0
      player2_result.bucholtz.should eq 1.0
      player2_result.games_count.should eq 1
    end

    it 'should fill all data in result - 2' do
      @round2 = FactoryGirl.create(:round, tournament: @tournament)
      @tournament.reload
      Game.create!(white_player: @player1, white_player_id: @player1.id , black_player: @player2, black_player_id: @player2.id, round: @tournament.rounds.first, result: 1)
      Game.create!(white_player: @player2, white_player_id: @player2.id , black_player: @player1, black_player_id: @player1.id, round: @tournament.rounds.second, result: 2)
      player1_result = @player1.results.first
      player2_result = @player2.results.first

      player1_result.points.should eq 1.5
      player1_result.progress.should eq 2.5
      player1_result.mini_bucholtz.should eq 0.0
      player1_result.bucholtz.should eq 1.0 # twice counted
      player1_result.games_count.should eq 2

      player2_result.points.should eq 0.5
      player2_result.progress.should eq 0.5
      player2_result.mini_bucholtz.should eq 0.0
      player2_result.bucholtz.should eq 3.0
      player2_result.games_count.should eq 2
    end

    it 'should fill all data in result - 3' do
      @round2 = FactoryGirl.create(:round, tournament: @tournament)
      @round3 = FactoryGirl.create(:round, tournament: @tournament)
      @tournament.reload
      Game.create!(white_player: @player1, white_player_id: @player1.id , black_player: @player2, black_player_id: @player2.id, round: @tournament.rounds.first, result: 1)
      Game.create!(white_player: @player2, white_player_id: @player2.id , black_player: @player1, black_player_id: @player1.id, round: @tournament.rounds.second, result: 2)
      Game.create!(white_player: @player2, white_player_id: @player2.id , black_player: @player1, black_player_id: @player1.id, round: @tournament.rounds.last, result: 1)
      player1_result = @player1.results.first
      player2_result = @player2.results.first

      player1_result.points.should eq 1.5
      player1_result.progress.should eq 4.0
      player1_result.mini_bucholtz.should eq 1.5
      player1_result.bucholtz.should eq 4.5 # thrice counted
      player1_result.games_count.should eq 3

      player2_result.points.should eq 1.5
      player2_result.progress.should eq 2.0
      player2_result.mini_bucholtz.should eq 1.5
      player2_result.bucholtz.should eq 4.5
      player2_result.games_count.should eq 3
    end

    it 'should fill all data in result - 3' do
      @round2 = FactoryGirl.create(:round, tournament: @tournament)
      @round3 = FactoryGirl.create(:round, tournament: @tournament)
      @player3 = FactoryGirl.create(:player, fide_id: 456, name: 'Carl')
      @player4= FactoryGirl.create(:player, fide_id: 654, name: 'Darren')
      @tournament.reload
      create_game(@player1, @player4, @round, 1)
      create_game(@player2, @player3, @round, 3)
      create_game(@player1, @player2, @round2, 1)
      create_game(@player4, @player3, @round2, 1)
      create_game(@player3, @player1, @round3, 2)
      create_game(@player2, @player4, @round3, 2)
      player1_result = @player1.results.first
      player2_result = @player2.results.first
      player3_result = @player3.results.first
      player4_result = @player4.results.first

      player1_result.points.should eq 2.5
      player1_result.progress.should eq 5.5
      player1_result.mini_bucholtz.should eq 1.5
      player1_result.bucholtz.should eq 3.5
      player1_result.games_count.should eq 3

      player2_result.points.should eq 0.5
      player2_result.progress.should eq 0.5
      player2_result.mini_bucholtz.should eq 1.5
      player2_result.bucholtz.should eq 5.5
      player2_result.games_count.should eq 3

      player3_result.points.should eq 1.5
      player3_result.progress.should eq 3.5
      player3_result.mini_bucholtz.should eq 1.5
      player3_result.bucholtz.should eq 4.5
      player3_result.games_count.should eq 3

      player4_result.points.should eq 1.5
      player4_result.progress.should eq 2.5
      player4_result.mini_bucholtz.should eq 1.5
      player4_result.bucholtz.should eq 4.5
      player4_result.games_count.should eq 3

    end

  end
end
